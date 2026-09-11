(() => {
  const allowedAnalyticsParams = new Set([
    "assessment_source_page", "assessment_source_cta", "assessment_step",
    "pipe_material", "building_type", "content_type", "content_topic",
    "site_section", "audience_type", "cta_id", "cta_location", "form_type",
    "resource_type", "case_study_id", "process_step", "unit_count_bucket",
  ]);
  const cleanAnalyticsValue = (value) => String(value ?? "").replace(/[\u0000-\u001f\u007f]/g, "").trim().slice(0, 100);
  const track = (eventName, params = {}) => {
    if (!/^[a-z][a-z0-9_]{0,63}$/.test(eventName)) return;
    const safeParams = Object.fromEntries(Object.entries(params)
      .filter(([key, value]) => allowedAnalyticsParams.has(key) && value !== undefined && value !== null)
      .map(([key, value]) => [key, cleanAnalyticsValue(value)]));
    if (typeof window.gtag === "function") window.gtag("event", eventName, safeParams);
    else {
      window.dataLayer = window.dataLayer || [];
      window.dataLayer.push({ event: eventName, ...safeParams });
    }
  };
  window.ptTrack = window.ptTrack || track;
  const measurementId = document.documentElement.dataset.ga4MeasurementId || window.PT_GA4_MEASUREMENT_ID;
  if (measurementId && !window.__ptGa4Initialized) {
    window.__ptGa4Initialized = true;
    window.dataLayer = window.dataLayer || [];
    window.gtag = window.gtag || function gtag() { window.dataLayer.push(arguments); };
    window.gtag("js", new Date());
    window.gtag("config", cleanAnalyticsValue(measurementId), { send_page_view: true });
    const analyticsScript = document.createElement("script");
    analyticsScript.async = true;
    analyticsScript.src = `https://www.googletagmanager.com/gtag/js?id=${encodeURIComponent(cleanAnalyticsValue(measurementId))}`;
    document.head.append(analyticsScript);
  }

  const startPage = () => {
  const root = document.querySelector("[data-pt-page]");
  if (!root || root.dataset.ptReady === "true") return;

  root.dataset.ptReady = "true";
  root.classList.add("pt-js");

  const familyHeroImages = {
    "/about/": "/img/about-building.png",
    "/resources/": "/img/our-work/dover-pointe.webp",
    "/resources/faq/": "/img/our-work/the-newbury.webp",
    "/solutions/": "/img/our-work/brandts-crossing.webp",
    "/solutions/poly-b/": "/img/our-work/kelvin-court.webp",
    "/solutions/kitec/": "/img/our-work/peregrine-point.webp",
    "/how-it-works/installation/": "/img/our-work/rutland-house.webp",
    "/technology/": "/img/completed-work/web/step-03-ceiling.webp",
    "/technology/accessible-plumbing/": "/img/completed-work/web/step-07-access.webp",
    "/technology/conventional-vs-plumbing-track/": "/img/completed-work/web/step-02-routing.webp",
  };
  const familyHero = root.querySelector(".family-hero:not(.family-hero--photo)");
  const familyHeroImage = familyHeroImages[window.location.pathname];
  if (familyHero && familyHeroImage) {
    familyHero.classList.add("family-hero--photo");
    familyHero.style.setProperty("--family-hero-image", `url('${familyHeroImage}')`);
  }

  root.querySelectorAll("[data-assessment-cta]").forEach((cta) => {
    cta.addEventListener("click", () => {
      const sourceCta = cta.getAttribute("data-assessment-cta") || "unknown";
      sessionStorage.setItem("assessment_source_page", window.location.pathname);
      sessionStorage.setItem("assessment_source_cta", sourceCta);
      const eventParams = {
        assessment_source_page: window.location.pathname,
        assessment_source_cta: sourceCta,
      };
      if (typeof window.ptTrack === "function") window.ptTrack("assessment_cta_click", eventParams);
    });
  });

  const reducedMotion = window.matchMedia(
    "(prefers-reduced-motion: reduce)"
  );
  const narrowViewport = window.matchMedia("(max-width: 1240px)");
  const header = root.querySelector("[data-pt-header]");
  const menuToggle = header?.querySelector(".header-menu-toggle");
  const siteNav = header?.querySelector("#site-nav");
  const hero = root.querySelector("[data-pt-hero]");
  const heroCover = hero?.nextElementSibling;
  const proof = root.querySelector("[data-pt-proof]");
  const proofLayer = root.querySelector("[data-pt-media-layer]");
  const stackPanels = Array.from(
    root.querySelectorAll("[data-pt-stack-panel]")
  );
  const parallaxRows = Array.from(
    root.querySelectorAll("[data-pt-parallax-row]")
  );
  const navSections = siteNav
    ? Array.from(siteNav.querySelectorAll(".nav-section"))
    : [];

  const closeNavSections = (except = null) => {
    navSections.forEach((section) => {
      if (section !== except) section.open = false;
    });
  };

  const setNavOpen = (open) => {
    if (!header || !menuToggle) return;
    header.classList.toggle("is-nav-open", open);
    menuToggle.setAttribute("aria-expanded", open ? "true" : "false");
    menuToggle.setAttribute("aria-label", open ? "Close menu" : "Menu");
    if (!open) closeNavSections();
  };

  if (menuToggle && siteNav && header) {
    menuToggle.addEventListener("click", (event) => {
      event.stopPropagation();
      setNavOpen(!header.classList.contains("is-nav-open"));
    });

    siteNav.querySelectorAll("a").forEach((link) => {
      link.addEventListener("click", () => setNavOpen(false));
    });

    navSections.forEach((section) => {
      section.addEventListener("toggle", () => {
        if (section.open) closeNavSections(section);
      });
    });

    document.addEventListener("pointerdown", (event) => {
      if (event.target.closest(".nav-section")) return;
      closeNavSections();
      if (!event.target.closest("#site-nav")) setNavOpen(false);
    }, true);

    document.addEventListener("keydown", (event) => {
      if (event.key !== "Escape") return;
      if (!header.classList.contains("is-nav-open")) return;
      setNavOpen(false);
      menuToggle.focus();
    });

    const syncNavToViewport = () => {
      if (!narrowViewport.matches) setNavOpen(false);
    };
    narrowViewport.addEventListener?.("change", syncNavToViewport);
  }

  const cardRevealSelector = [
    ".home-project",
    ".route-card",
    ".project-item",
    ".portal-grid > li",
    ".partner-grid > li",
    ".advantage-card",
  ].join(",");

  root.querySelectorAll(".reveal").forEach((element) => {
    if (!element.matches(cardRevealSelector)) return;
    element.dataset.ptCardReveal = "true";
    element.style.transitionDuration = "420ms, 340ms, 420ms";
  });

  root.querySelectorAll("[data-pt-stagger]").forEach((group) => {
    const containsCards = Boolean(group.querySelector(cardRevealSelector));
    const step = group.hasAttribute("data-pt-stagger-fast") || containsCards ? 45 : 110;
    group.querySelectorAll(".reveal").forEach((element, index) => {
      element.style.setProperty(
        "--pt-reveal-delay",
        `${Math.min(index, 5) * step}ms`
      );
    });
  });

  root.querySelectorAll('a[href^="#"]').forEach((link) => {
    link.addEventListener("click", (event) => {
      const selector = link.getAttribute("href");
      if (!selector || selector === "#") return;
      const target = root.querySelector(selector);
      if (!target) return;

      event.preventDefault();
      const behavior = reducedMotion.matches ? "auto" : "smooth";

      // Sticky hero stays painted in the viewport while later panels
      // cover it, so scrollIntoView(#top) can stop short of y=0.
      if (selector === "#top" || target.hasAttribute("data-pt-hero")) {
        window.scrollTo({ top: 0, behavior });
        return;
      }

      target.scrollIntoView({
        behavior,
        block: "start",
      });
    });
  });

  const revealAll = () => {
    root
      .querySelectorAll(".reveal")
      .forEach((element) => element.classList.add("is-visible"));
  };

  if (!("IntersectionObserver" in window) || reducedMotion.matches) {
    revealAll();
  } else {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return;
          entry.target.classList.add("is-visible");
          observer.unobserve(entry.target);
        });
      },
      {
        rootMargin: "0px 0px -4% 0px",
        threshold: 0.06,
      }
    );

    root
      .querySelectorAll(".reveal")
      .forEach((element) => observer.observe(element));
  }

  if (
    root.hasAttribute("data-pt-early-lazy") &&
    "IntersectionObserver" in window
  ) {
    const earlyLazy = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (!entry.isIntersecting) return;
          const img = entry.target;
          if (img.getAttribute("loading") === "lazy") {
            img.loading = "eager";
          }
          earlyLazy.unobserve(img);
        });
      },
      { rootMargin: "700px 0px", threshold: 0.01 }
    );
    root
      .querySelectorAll('img[loading="lazy"]')
      .forEach((img) => earlyLazy.observe(img));
  }

  let frameRequested = false;

  const clamp = (value, minimum, maximum) =>
    Math.min(Math.max(value, minimum), maximum);

  const resetStackMotion = () => {
    root.style.setProperty("--pt-hero-progress", "0");
    stackPanels.forEach((panel) => {
      panel.style.setProperty("--pt-stack-media-shift", "0px");
      panel.style.setProperty("--pt-stack-copy-shift", "0px");
    });
  };

  const updateStackMotion = () => {
    if (reducedMotion.matches) {
      resetStackMotion();
      return;
    }

    const viewportHeight = window.innerHeight || 1;

    stackPanels.forEach((panel, index) => {
      const rect = panel.getBoundingClientRect();
      const progress = clamp(-rect.top / Math.max(viewportHeight, 1), 0, 1);
      // Counter-parallax while panel is the active pinned surface.
      const mediaShift = (0.5 - progress) * viewportHeight * 0.05;
      const copyShift = (progress - 0.5) * viewportHeight * 0.02;

      panel.style.setProperty(
        "--pt-stack-media-shift",
        `${mediaShift.toFixed(2)}px`
      );
      panel.style.setProperty(
        "--pt-stack-copy-shift",
        `${copyShift.toFixed(2)}px`
      );

      if (index === 0) {
        root.style.setProperty("--pt-hero-progress", progress.toFixed(4));
      }
    });
  };

  const updateHeaderState = () => {
    // Keep the transparent treatment through the first 50px, then switch to
    // the solid, readable header state.
    header?.classList.toggle("is-scrolled", window.scrollY > 50);
  };

  const updateMotion = () => {
    frameRequested = false;
    updateHeaderState();

    updateStackMotion();

    if (reducedMotion.matches) {
      proofLayer?.style.setProperty("--pt-proof-shift", "0px");
      parallaxRows.forEach((row) => {
        row.style.setProperty("--pt-copy-shift", "0px");
        row.style.setProperty("--pt-media-shift", "0px");
      });
      return;
    }

    if (proof && proofLayer) {
      const rect = proof.getBoundingClientRect();
      const distanceFromViewportCenter =
        window.innerHeight / 2 - (rect.top + rect.height / 2);
      const shift = clamp(distanceFromViewportCenter * 0.045, -28, 28);
      proofLayer.style.setProperty("--pt-proof-shift", `${shift.toFixed(2)}px`);
    }

    parallaxRows.forEach((row) => {
      const rect = row.getBoundingClientRect();
      if (rect.bottom < -180 || rect.top > window.innerHeight + 180) return;

      const distanceFromViewportCenter =
        window.innerHeight / 2 - (rect.top + rect.height / 2);
      const copyShift = clamp(distanceFromViewportCenter * 0.08, -46, 46);
      const mediaShift = clamp(distanceFromViewportCenter * -0.115, -68, 68);

      row.style.setProperty("--pt-copy-shift", `${copyShift.toFixed(2)}px`);
      row.style.setProperty("--pt-media-shift", `${mediaShift.toFixed(2)}px`);
    });
  };

  const requestMotionUpdate = () => {
    if (frameRequested) return;
    frameRequested = true;
    window.requestAnimationFrame(updateMotion);
  };

  window.addEventListener("scroll", requestMotionUpdate, { passive: true });
  window.addEventListener("resize", requestMotionUpdate, { passive: true });
  reducedMotion.addEventListener?.("change", requestMotionUpdate);
  narrowViewport.addEventListener?.("change", requestMotionUpdate);

	root
    .querySelector("[data-assessment-form]")
    ?.addEventListener("submit", async (event) => {
      event.preventDefault();
      const form = event.currentTarget;
      if (!(form instanceof HTMLFormElement)) return;

      const button = form.querySelector('button[type="submit"]');
      let status = form.querySelector("[data-assessment-status]");
      if (!status) {
        status = document.createElement("p");
        status.setAttribute("data-assessment-status", "");
        status.setAttribute("role", "status");
        status.style.marginTop = "12px";
        status.style.fontSize = "14px";
        form.appendChild(status);
      }

      const payload = {
        buildingSize: form.buildingSize?.value?.trim?.() || "",
        units: form.units?.value?.trim?.() || "",
        location: form.location?.value?.trim?.() || "",
        contactInfo: form.contactInfo?.value?.trim?.() || "",
      };

      if (!payload.contactInfo) {
        status.textContent = "Please add your contact info so we can reach you.";
        status.style.color = "#b91c1c";
        return;
      }

      if (button instanceof HTMLButtonElement) button.disabled = true;
      status.textContent = "Sending…";
      status.style.color = "#475569";

      try {
        const response = await fetch("/api/public/assessment", {
          method: "POST",
          headers: { "Content-Type": "application/json", Accept: "application/json" },
          body: JSON.stringify(payload),
        });
        if (!response.ok) {
          let message = "Something went wrong. Please try again or email us directly.";
          try {
            const data = await response.json();
            if (data?.message) message = String(data.message);
          } catch (_) {}
          throw new Error(message);
        }
        status.textContent = "Thanks, we received your request and will be in touch soon.";
        status.style.color = "#047857";
        form.reset();
      } catch (error) {
        status.textContent =
          error instanceof Error
            ? error.message
            : "Something went wrong. Please try again or email us directly.";
        status.style.color = "#b91c1c";
      } finally {
        if (button instanceof HTMLButtonElement) button.disabled = false;
      }
    });

  const heroVideo = root.querySelector(".hero-video video");
  const syncHeroVideo = () => {
    if (!heroVideo) return;
    if (reducedMotion.matches) {
      heroVideo.pause();
      return;
    }
    const playPromise = heroVideo.play();
    if (playPromise?.catch) playPromise.catch(() => {});
  };

  reducedMotion.addEventListener?.("change", syncHeroVideo);
  syncHeroVideo();

  const testimonialRoot = root.querySelector("[data-pt-testimonials]");
  const testimonialQuotes = Array.from(
    root.querySelectorAll("[data-pt-testimonial-quote]")
  );
  const testimonialImages = Array.from(
    root.querySelectorAll("[data-pt-testimonial-media] img")
  );

  if (
    testimonialRoot &&
    testimonialQuotes.length > 1 &&
    testimonialImages.length === testimonialQuotes.length
  ) {
    let activeIndex = 0;
    let advancing = false;
    let inView = false;
    let timerId = 0;
    const dwellMs = 4800;

    const setActiveImage = (index) => {
      testimonialImages.forEach((image, imageIndex) => {
        image.classList.toggle("is-active", imageIndex === index);
      });
    };

    const advanceTestimonials = () => {
      if (advancing) return;
      advancing = true;

      const currentQuote = testimonialQuotes[activeIndex];
      const nextIndex = (activeIndex + 1) % testimonialQuotes.length;
      const nextQuote = testimonialQuotes[nextIndex];
      const transitionMs = reducedMotion.matches ? 0 : 700;

      currentQuote.classList.remove("is-active");
      currentQuote.classList.add("is-exit");
      nextQuote.classList.add("is-active");
      setActiveImage(nextIndex);

      window.setTimeout(() => {
        currentQuote.classList.remove("is-exit");
        activeIndex = nextIndex;
        advancing = false;
      }, transitionMs);
    };

    const stopTestimonials = () => {
      window.clearInterval(timerId);
      timerId = 0;
    };

    const startTestimonials = () => {
      stopTestimonials();
      if (!inView || document.hidden) return;
      timerId = window.setInterval(advanceTestimonials, dwellMs);
    };

    document.addEventListener("visibilitychange", () => {
      if (document.hidden) stopTestimonials();
      else startTestimonials();
    });

    if ("IntersectionObserver" in window) {
      const observer = new IntersectionObserver(
        (entries) => {
          inView = entries.some((entry) => entry.isIntersecting);
          if (inView) startTestimonials();
          else stopTestimonials();
        },
        { threshold: 0.35 }
      );
      observer.observe(testimonialRoot);
    } else {
      inView = true;
      startTestimonials();
    }
  }

  const processRoot = root.querySelector("[data-pt-process]");
  const processSlides = Array.from(
    root.querySelectorAll("[data-pt-process-slide]")
  );
  const processSteps = Array.from(
    root.querySelectorAll("[data-pt-process-step]")
  );
  const processJumps = Array.from(
    root.querySelectorAll("[data-pt-process-jump]")
  );
  const processPrev = root.querySelector("[data-pt-process-prev]");
  const processNext = root.querySelector("[data-pt-process-next]");

  if (
    processRoot &&
    processSlides.length > 1 &&
    processSlides.length === processSteps.length
  ) {
    let activeIndex = 0;
    let inView = false;
    let timerId = 0;
    const dwellMs = 5600;

    const setProcessIndex = (nextIndex) => {
      const index =
        ((nextIndex % processSlides.length) + processSlides.length) %
        processSlides.length;
      activeIndex = index;

      processSlides.forEach((slide, slideIndex) => {
        slide.classList.toggle("is-active", slideIndex === index);
      });
      processSteps.forEach((step, stepIndex) => {
        step.classList.toggle("is-active", stepIndex === index);
      });
      processJumps.forEach((jump, jumpIndex) => {
        const selected = jumpIndex === index;
        jump.classList.toggle("is-active", selected);
        jump.setAttribute("aria-selected", selected ? "true" : "false");
      });
    };

    const advanceProcess = (direction = 1) => {
      setProcessIndex(activeIndex + direction);
    };

    const stopProcess = () => {
      window.clearInterval(timerId);
      timerId = 0;
    };

    const startProcess = () => {
      stopProcess();
      if (!inView || document.hidden || reducedMotion.matches) return;
      timerId = window.setInterval(() => advanceProcess(1), dwellMs);
    };

    processPrev?.addEventListener("click", () => {
      advanceProcess(-1);
      startProcess();
    });
    processNext?.addEventListener("click", () => {
      advanceProcess(1);
      startProcess();
    });
    processJumps.forEach((jump) => {
      jump.addEventListener("click", () => {
        const target = Number(jump.getAttribute("data-pt-process-jump"));
        if (Number.isNaN(target)) return;
        setProcessIndex(target);
        startProcess();
      });
    });

    processRoot.addEventListener("keydown", (event) => {
      if (event.key === "ArrowLeft") {
        event.preventDefault();
        advanceProcess(-1);
        startProcess();
      } else if (event.key === "ArrowRight") {
        event.preventDefault();
        advanceProcess(1);
        startProcess();
      }
    });

    document.addEventListener("visibilitychange", () => {
      if (document.hidden) stopProcess();
      else startProcess();
    });

    reducedMotion.addEventListener?.("change", () => {
      if (reducedMotion.matches) stopProcess();
      else startProcess();
    });

    if ("IntersectionObserver" in window) {
      const observer = new IntersectionObserver(
        (entries) => {
          inView = entries.some((entry) => entry.isIntersecting);
          if (inView) startProcess();
          else stopProcess();
        },
        { threshold: 0.35 }
      );
      observer.observe(processRoot);
    } else {
      inView = true;
      startProcess();
    }
  }

  window.requestAnimationFrame(() => {
    root.classList.add("is-ready");
    updateMotion();
  });
  };

  const headerReady = window.ptHeaderReady;
  if (headerReady && typeof headerReady.then === "function") {
    headerReady.then(startPage);
  } else {
    startPage();
  }
})();
