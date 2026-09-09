(() => {
  const form = document.querySelector("[data-assessment-flow]");
  if (!(form instanceof HTMLFormElement)) return;

  const steps = Array.from(form.querySelectorAll("[data-step]"));
  const progress = Array.from(form.querySelectorAll(".progress li"));
  const review = form.querySelector("[data-review]");
  const status = form.querySelector("[data-status]");
  const success = document.querySelector("[data-success]");
  const params = new URLSearchParams(window.location.search);
  const sourcePage = params.get("source_page") || sessionStorage.getItem("assessment_source_page") || window.location.pathname;
  const sourceCta = params.get("source_cta") || sessionStorage.getItem("assessment_source_cta") || "direct";
  let currentStep = 0;
  let started = false;
  let submitting = false;

  const track = (eventName, extra = {}) => {
    const eventParams = {
      assessment_source_page: sourcePage,
      assessment_source_cta: sourceCta,
      ...extra,
    };
    if (typeof window.gtag === "function") window.gtag("event", eventName, eventParams);
    else {
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({ event: eventName, ...eventParams });
    }
  };

  const value = (name) => String(new FormData(form).get(name) || "").trim();
  const radioValue = (name) => form.querySelector(`input[name="${name}"]:checked`)?.value || "";

  const showStep = (index) => {
    currentStep = Math.max(0, Math.min(index, steps.length - 1));
    steps.forEach((step, stepIndex) => { step.hidden = stepIndex !== currentStep; });
    progress.forEach((item, itemIndex) => {
      item.classList.toggle("is-active", itemIndex === currentStep);
      item.classList.toggle("is-complete", itemIndex < currentStep);
    });
    if (currentStep === 3) populateReview();
    const heading = steps[currentStep]?.querySelector("legend");
    heading?.focus?.();
  };

  const validateStep = () => {
    const required = Array.from(steps[currentStep].querySelectorAll("[required]"));
    const invalid = required.find((field) => !field.checkValidity());
    if (!invalid) return true;
    invalid.reportValidity();
    return false;
  };

  const reviewRows = () => [
    ["Building", value("building_name")], ["Location", value("building_location")], ["City or region", value("building_region")],
    ["Building type", value("building_type")], ["Units", value("unit_count")], ["Occupancy", radioValue("occupancy")],
    ["Pipe material", radioValue("pipe_material")], ["Assessment reason", value("issue_type")], ["Timing", value("project_timing")],
    ["Project concerns", value("project_concerns")], ["Additional notes", value("project_notes")],
    ["Name", value("contact_name")], ["Organization", value("contact_organization")], ["Role", value("contact_role")],
    ["Email", value("contact_email")], ["Phone", value("contact_phone")], ["Preferred contact", value("preferred_contact")],
  ];

  const populateReview = () => {
    if (!review) return;
    review.replaceChildren();
    reviewRows().filter(([, entry]) => entry).forEach(([label, entry]) => {
      const row = document.createElement("div");
      const term = document.createElement("dt");
      const detail = document.createElement("dd");
      term.textContent = label;
      detail.textContent = entry;
      row.append(term, detail);
      review.append(row);
    });
  };

  const payload = () => ({
    building: { name: value("building_name"), location: value("building_location"), region: value("building_region"), type: value("building_type"), unit_count: value("unit_count"), occupancy: radioValue("occupancy") },
    project: { pipe_material: radioValue("pipe_material"), issue_type: value("issue_type"), timing: value("project_timing"), concerns: value("project_concerns"), notes: value("project_notes") },
    contact: { name: value("contact_name"), organization: value("contact_organization"), role: value("contact_role"), email: value("contact_email"), phone: value("contact_phone"), preferred_contact: value("preferred_contact") },
    attribution: { source_page: sourcePage, source_cta: sourceCta, submitted_at: new Date().toISOString() },
    // Compatibility fields retain the existing API handoff while the backend adopts the structured shape.
    buildingSize: value("building_name"), units: value("unit_count"), location: [value("building_location"), value("building_region")].filter(Boolean).join(", "), contactInfo: [value("contact_name"), value("contact_email"), value("contact_phone")].filter(Boolean).join(" | "),
  });

  form.addEventListener("input", () => { if (!started) { started = true; track("assessment_started"); } }, { once: true });
  form.addEventListener("change", () => { if (!started) { started = true; track("assessment_started"); } }, { once: true });

  form.querySelectorAll("[data-next]").forEach((button) => button.addEventListener("click", () => {
    if (!validateStep()) return;
    track("assessment_step_completed", { assessment_step: currentStep + 1, pipe_material: radioValue("pipe_material") || "unspecified", building_type: value("building_type") || "unspecified" });
    showStep(currentStep + 1);
  }));
  form.querySelectorAll("[data-back]").forEach((button) => button.addEventListener("click", () => showStep(currentStep - 1)));

  form.addEventListener("submit", async (event) => {
    event.preventDefault();
    if (submitting) return;
    if (!validateStep()) return;
    submitting = true;
    const submit = form.querySelector('button[type="submit"]');
    if (submit instanceof HTMLButtonElement) submit.disabled = true;
    status.textContent = "Sending your assessment request…";
    status.className = "status";
    try {
      const response = await fetch("/api/public/assessment", { method: "POST", headers: { "Content-Type": "application/json", Accept: "application/json" }, body: JSON.stringify(payload()) });
      if (!response.ok) {
        let message = "Something went wrong. Please try again.";
        try { const body = await response.json(); if (body?.message) message = String(body.message); } catch (_) {}
        throw new Error(message);
      }
      track("assessment_submitted", { pipe_material: radioValue("pipe_material") || "unspecified", building_type: value("building_type") || "unspecified" });
      sessionStorage.setItem("assessment_submitted", "true");
      form.hidden = true;
      success.hidden = false;
      success.focus();
    } catch (error) {
      status.textContent = error instanceof Error ? error.message : "Something went wrong. Please try again.";
      status.className = "status is-error";
      submitting = false;
      if (submit instanceof HTMLButtonElement) submit.disabled = false;
    }
  });
})();
