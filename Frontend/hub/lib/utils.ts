import { type ClassValue, clsx } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

export function getThemeColor() {
  if (typeof window !== "undefined") {
    // Check if there's a color preset in localStorage
    const root = document.documentElement
    const colorPreset = root.classList.toString().match(/preset-(\w+)/)?.[1] || "green"

    // Return the appropriate color based on the preset
    switch (colorPreset) {
      case "purple":
        return "#8b5cf6" // Tailwind purple-500
      case "blue":
        return "#3b82f6" // Tailwind blue-500
      case "orange":
        return "#f97316" // Tailwind orange-500
      case "red":
        return "#ef4444" // Tailwind red-500
      case "indigo":
        return "#6366f1" // Tailwind indigo-500
      case "green":
      default:
        return "#10b981" // Tailwind emerald-500
    }
  }

  // Default color if running on server or no preset found
  return "#10b981"
}
