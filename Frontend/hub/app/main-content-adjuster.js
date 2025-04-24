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

  // Run on initial load
  document.addEventListener("DOMContentLoaded", adjustMainContent)

  // Set up a mutation observer to watch for changes to the sidebar
  const observer = new MutationObserver(adjustMainContent)

  // Start observing the sidebar for attribute changes
  setTimeout(() => {
    const sidebar = document.querySelector(".sidebar")
    if (sidebar) {
      observer.observe(sidebar, { attributes: true })
    }
  }, 500)
}

export {}
