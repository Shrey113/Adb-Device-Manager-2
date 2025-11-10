document.addEventListener("DOMContentLoaded", () => {
  // Register ScrollTrigger with GSAP
  gsap.registerPlugin(ScrollTrigger);

  // Navbar animations
  gsap.to(".fade-in", {
    opacity: 1,
    duration: 1,
    stagger: 0.2,
    ease: "power2.out",
  });

  // Hero animations
  gsap.to(".slide-up", {
    y: 0,
    opacity: 1,
    duration: 1,
    stagger: 0.2,
    ease: "power2.out",
  });

  // Dashboard card animations
  gsap.to(".scale-in", {
    scale: 1,
    opacity: 1,
    duration: 0.8,
    stagger: 0.1,
    ease: "back.out(1.7)",
  });

  // Chart bars animation
  gsap.to(".chart-bar.critical-bar", {
    width: "65%",
    duration: 1.5,
    delay: 0.5,
    ease: "power2.out",
  });

  gsap.to(".chart-bar.high-bar", {
    width: "25%",
    duration: 1.2,
    delay: 0.7,
    ease: "power2.out",
  });

  gsap.to(".chart-bar.low-bar", {
    width: "10%",
    duration: 1,
    delay: 0.9,
    ease: "power2.out",
  });

  // Section animations with ScrollTrigger
  gsap.utils.toArray(".section-container").forEach((section, i) => {
    // Section header animations
    gsap.to(section.querySelectorAll(".tagline, h2, .subtitle"), {
      scrollTrigger: {
        trigger: section,
        start: "top 80%",
      },
      y: 0,
      opacity: 1,
      duration: 0.8,
      stagger: 0.2,
      ease: "power2.out",
    });

    // Section content animations
    gsap.to(section.querySelectorAll(".scale-in"), {
      scrollTrigger: {
        trigger: section,
        start: "top 70%",
      },
      scale: 1,
      opacity: 1,
      duration: 0.8,
      stagger: 0.1,
      ease: "back.out(1.7)",
    });

    // Feature cards animations
    gsap.to(
      section.querySelectorAll(
        ".feature-card, .testimonial-card, .pricing-card"
      ),
      {
        scrollTrigger: {
          trigger: section,
          start: "top 70%",
        },
        y: 0,
        opacity: 1,
        duration: 0.8,
        stagger: 0.1,
        ease: "power2.out",
      }
    );
  });

  // Hover effects for feature cards
  const featureCards = document.querySelectorAll(".feature-card");
  featureCards.forEach((card) => {
    card.addEventListener("mouseenter", () => {
      gsap.to(card, {
        y: -10,
        duration: 0.3,
        ease: "power2.out",
      });
    });

    card.addEventListener("mouseleave", () => {
      gsap.to(card, {
        y: 0,
        duration: 0.3,
        ease: "power2.out",
      });
    });
  });

  // Device mockup interactions
  const deviceScreen = document.querySelector(".device-screen");
  const appScreens = document.querySelectorAll(".app-screen");
  const navButtons = document.querySelectorAll(".app-button");
  const backButton = document.querySelector(".back-button");

  // Update screen classes when changing screens
  function updateScreenClasses(targetScreen, animationType) {
    // If navigating to main, just hide all overlays
    if (targetScreen === "main") {
      appScreens.forEach((screen) => {
        if (!screen.classList.contains("screen-main")) {
          // Apply exit animation if it's currently active
          if (screen.classList.contains("active")) {
            screen.classList.remove("active");
            screen.classList.add("animating-out");

            // After animation, hide completely
            setTimeout(() => {
              screen.classList.remove("animating-out");
              screen.style.display = "none";
            }, 400);
          }
        }
      });

      // Update device screen class
      deviceScreen.className = "device-screen";
      deviceScreen.classList.add("on-main-screen");
      return;
    }

    // Get current active overlay screen (if any)
    let currentScreen = null;
    appScreens.forEach((screen) => {
      if (
        screen.classList.contains("active") &&
        !screen.classList.contains("screen-main")
      ) {
        currentScreen = screen;
      }
    });

    // Apply exit animation to current overlay screen if it exists
    if (currentScreen) {
      // Remove active class to start animation
      currentScreen.classList.remove("active");

      // Add animating-out class for exit animation
      currentScreen.classList.add("animating-out");

      // After animation completes, hide screen completely
      setTimeout(() => {
        currentScreen.classList.remove("animating-out");
        currentScreen.style.display = "none";

        // Now show new overlay screen with entry animation
        showOverlayScreen(targetScreen);
      }, 400);
    } else {
      // No active overlay screen, just show the target
      showOverlayScreen(targetScreen);
    }
  }

  function showOverlayScreen(targetScreen) {
    // Find target screen element
    const activeScreen = document.querySelector(`.screen-${targetScreen}`);

    if (activeScreen) {
      // Make sure screen is visible before animation
      activeScreen.style.display = "block";

      // Start entry animation
      activeScreen.classList.add("animating-in");

      // After animation, set to active state
      setTimeout(() => {
        activeScreen.classList.add("active");
        activeScreen.classList.remove("animating-in");

        // Update device screen class for proper button visibility
        deviceScreen.className = "device-screen";
        deviceScreen.classList.add(`on-${targetScreen}-screen`);
      }, 500);
    }
  }

  // Screen navigation
  navButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      e.stopPropagation(); // Prevent event bubbling
      const targetScreen = this.getAttribute("data-target");
      console.log("Navigating to:", targetScreen);

      // Special handling for beta button to show popup instead
      if (targetScreen === "beta") {
        // Show beta popup overlay inside device frame
        const betaPopup = document.querySelector(
          ".device-screen .beta-popup-overlay"
        );
        if (betaPopup) {
          betaPopup.classList.add("active");
        }
        return; // Skip normal navigation
      }

      // Update screen classes with animation
      updateScreenClasses(targetScreen);
    });
  });

  // Handle beta popup close button
  const betaCloseBtn = document.querySelector(".beta-close-btn");
  if (betaCloseBtn) {
    betaCloseBtn.addEventListener("click", function () {
      const betaPopup = document.querySelector(
        ".device-screen .beta-popup-overlay"
      );
      if (betaPopup) {
        betaPopup.classList.remove("active");
      }
    });
  }

  // Close beta popup when clicking outside content
  const betaPopupOverlay = document.querySelector(
    ".device-screen .beta-popup-overlay"
  );
  if (betaPopupOverlay) {
    betaPopupOverlay.addEventListener("click", function (e) {
      if (e.target === betaPopupOverlay) {
        betaPopupOverlay.classList.remove("active");
      }
    });
  }

  // Initial setup - show main screen
  const mainScreen = document.querySelector(".screen-main");
  if (mainScreen) {
    mainScreen.classList.add("active");
    mainScreen.style.display = "block";
    deviceScreen.classList.add("on-main-screen");
  }
});

document.addEventListener("DOMContentLoaded", function () {
  const menuToggle = document.querySelector(".mobile-menu-toggle");
  const cta = document.querySelector("#section1 .cta");

  if (menuToggle && cta) {
    menuToggle.addEventListener("click", function () {
      cta.classList.toggle("active");
      // Change icon based on menu state
      const icon = menuToggle.querySelector("i");
      if (cta.classList.contains("active")) {
        icon.classList.remove("bi-list");
        icon.classList.add("bi-x-lg");
      } else {
        icon.classList.remove("bi-x-lg");
        icon.classList.add("bi-list");
      }
    });

    // Close menu when clicking outside
    document.addEventListener("click", function (e) {
      if (
        !cta.contains(e.target) &&
        !menuToggle.contains(e.target) &&
        cta.classList.contains("active")
      ) {
        cta.classList.remove("active");
        const icon = menuToggle.querySelector("i");
        icon.classList.remove("bi-x-lg");
        icon.classList.add("bi-list");
      }
    });
  }
});
