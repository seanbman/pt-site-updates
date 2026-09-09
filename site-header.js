(() => {
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

  const headerMount = document.querySelector("[data-pt-header-fragment]");
  const footerMount = document.querySelector("[data-pt-footer-fragment]");

  window.ptHeaderReady = loadFragment(headerMount, "/templates/site-header.html")
    .then(() => {
      const currentPath = window.location.pathname.replace(/\/+$/, "") || "/";
      const currentLink = document.querySelector(
        `[data-pt-header] a[href="${currentPath === "/" ? "/" : `${currentPath}/`}"]`
      );
      currentLink?.setAttribute("aria-current", "page");
    });

  window.ptFooterReady = loadFragment(footerMount, "/templates/site-footer.html");
})();
