(() => {
  const routeHowItWorks = () => {
    const heroLink = document.querySelector('.hero-actions a[href="#how-it-works"]');
    if (heroLink) heroLink.href = "/how-it-works/";

    const previewLink = document.querySelector('a[data-assessment-cta="how-it-works-preview"]');
    if (previewLink) {
      previewLink.href = "/how-it-works/";
      previewLink.removeAttribute("data-assessment-cta");
      previewLink.innerHTML = 'See how it works <span aria-hidden="true">›</span>';
    }
  };

  const loadFragment = (mount, path) => {
    if (!mount) return Promise.resolve();
    return fetch(path)
      .then((response) => {
        if (!response.ok) throw new Error(`Shared fragment failed: ${response.status}`);
        return response.text();
      })
      .then((markup) => { mount.outerHTML = markup; })
      .catch((error) => { console.error(error); });
  };

  routeHowItWorks();

  const headerMount = document.querySelector("[data-pt-header-fragment]");
  const footerMount = document.querySelector("[data-pt-footer-fragment]");
  const testimonialMounts = Array.from(document.querySelectorAll("[data-pt-testimonial-cards-fragment]"));

  window.ptHeaderReady = loadFragment(headerMount, "/templates/site-header.html")
    .then(() => {
      const currentPath = window.location.pathname.replace(/\/+$/, "") || "/";
      const currentLink = document.querySelector(
        `[data-pt-header] a[href="${currentPath === "/" ? "/" : `${currentPath}/`}"]`
      );
      currentLink?.setAttribute("aria-current", "page");
    });

  window.ptFooterReady = loadFragment(footerMount, "/templates/site-footer.html");
  window.ptTestimonialCardsReady = Promise.all(
    testimonialMounts.map((mount) => loadFragment(mount, "/templates/testimonial-cards.html"))
  );
})();
