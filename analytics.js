(() => {
  const allowedParams = new Set([
    "assessment_source_page", "assessment_source_cta", "assessment_step",
    "pipe_material", "building_type", "content_type", "content_topic",
    "site_section", "audience_type", "cta_id", "cta_location", "form_type",
    "resource_type", "case_study_id", "process_step", "unit_count_bucket",
  ]);

  const cleanValue = (value) => String(value ?? "").replace(/[\u0000-\u001f\u007f]/g, "").trim().slice(0, 100);
  const cleanParams = (params) => Object.fromEntries(
    Object.entries(params).filter(([key, value]) => allowedParams.has(key) && value !== undefined && value !== null)
      .map(([key, value]) => [key, cleanValue(value)]),
  );

  const track = (eventName, params = {}) => {
    if (!/^[a-z][a-z0-9_]{0,63}$/.test(eventName)) return;
    const eventParams = cleanParams(params);
    if (typeof window.gtag === "function") window.gtag("event", eventName, eventParams);
    else {
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({ event: eventName, ...eventParams });
    }
  };

  window.ptTrack = track;

  const measurementId = document.documentElement.dataset.ga4MeasurementId || window.PT_GA4_MEASUREMENT_ID;
  if (!measurementId || window.__ptGa4Initialized) return;
  window.__ptGa4Initialized = true;
  window.dataLayer = window.dataLayer || [];
  window.gtag = window.gtag || function gtag() { window.dataLayer.push(arguments); };
  window.gtag("js", new Date());
  window.gtag("config", cleanValue(measurementId), { send_page_view: true });
  const script = document.createElement("script");
  script.async = true;
  script.src = `https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(cleanValue(measurementId))}`;
  document.head.append(script);
})();
