"use client"

if (typeof window !== "undefined") {
  // Function to adjust main content margin based on sidebar width
  const adjustMainContent = () => {
    const sidebar = document.querySelector(".sidebar")
    const mainContent = document.getElementById("main-content")

    if (sidebar && mainContent) {
      const sidebarWidth = sidebar.offsetWidth
      mainContent.style.marginLeft = `${sidebarWidth}px`
    }
  }

  // Run on initial load and window resize
  document.addEventListener("DOMContentLoaded", adjustMainContent)
  window.addEventListener("resize", adjustMainContent)
}

export {}
