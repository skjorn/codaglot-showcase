
var lastWindowWidth;
var sideMenuExpanded = false;

installActionHandlers();
expandSideMenuIfNeeded();

function expandSideMenuIfNeeded() {
    const params = new URLSearchParams(window.location.search);
    const expandValue = params.get("expand");
    const menuEl = document.getElementById("chapter-nav-phone");
    if (expandValue === "1") {
        expandSideNavigation(menuEl);
    } else {
        getSideMenuUl(menuEl).onclick = toggleSideNavigation
    }
}

function installActionHandlers() {
    // Phone side menu toggles
    const sideMenuToggles = document.querySelectorAll(".side-nav-toggle,.side-nav-toggle-inline");
    for (const toggleEl of sideMenuToggles) {
        toggleEl.onclick = toggleSideNavigation;
    }

    // Update expanded menu on window resize
    window.onresize = handleResize;
}

function toggleSideNavigation() {
    const menuEl = document.getElementById("chapter-nav-phone");
    if (menuEl.classList.contains("expanded")) {
        collapseSideNavigation(menuEl);
    } else {
        expandSideNavigation(menuEl);
    }
}

function expandSideNavigation(menuEl) {
    updatePanningOffset(menuEl);
    getSideMenuUl(menuEl).onclick = null;

    const pannedContentEl = document.getElementById("panned-content");
    for (const el of [pannedContentEl, menuEl, document.body]) {
        el.classList.add("expanded");
    }

    lastWindowWidth = window.innerWidth;
    setQueryParam("expand", "1");
    sideMenuExpanded = true;
}

function collapseSideNavigation(menuEl) {
    sideMenuExpanded = false;

    const pannedContentEl = document.getElementById("panned-content");
    for (const el of [pannedContentEl, menuEl, document.body]) {
        el.classList.remove("expanded");
    }

    document.documentElement.style.setProperty("--cglot-side-menu-offset", "0");
    getSideMenuUl(menuEl).onclick = toggleSideNavigation;
    removeQueryParam("expand");
}

function updatePanningOffset(menuEl) {
    const centeredColumn = document.querySelector("#main > div.centered-column");
    const cssWidth = `calc(${menuEl.offsetWidth - centeredColumn.offsetLeft}px + 0.85rem)`;
    document.documentElement.style.setProperty("--cglot-side-menu-offset", cssWidth);
}

function updatePanningOffsetIfExpanded() {
    if (!sideMenuExpanded) return;

    const windowWidth = window.innerWidth;
    if (Math.abs(lastWindowWidth - windowWidth) < 1) return;

    lastWindowWidth = windowWidth
    const menuEl = document.getElementById("chapter-nav-phone");
    updatePanningOffset(menuEl);
}

function handleResize() {
    updatePanningOffsetIfExpanded()
}

function getSideMenuUl(menuEl) {
    return menuEl.querySelector(':scope > ul');
}

function setQueryParam(name, value) {
    const params = new URLSearchParams(window.location.search);
    params.set(name, value);
    updateURL(params);
}

function removeQueryParam(name) {
    const params = new URLSearchParams(window.location.search);
    params.delete(name);
    updateURL(params);
}

function updateURL(searchParams) {
    const newUrl = `${window.location.pathname}?${searchParams.toString()}`;
    window.history.pushState({}, "", newUrl);
}
