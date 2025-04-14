"use client"

import type React from "react"

import { createContext, useContext, useEffect, useState } from "react"

type Theme = "light" | "dark"
type Direction = "ltr" | "rtl"
type Layout = "default" | "compact"
type ColorPreset = "green" | "purple" | "blue" | "orange" | "red" | "indigo"
export type StretchLevel = 0 | 1 | 2 | 3 | 4

interface ThemeContextType {
  theme: Theme
  setTheme: (theme: Theme) => void
  direction: Direction
  setDirection: (direction: Direction) => void
  layout: Layout
  setLayout: (layout: Layout) => void
  colorPreset: ColorPreset
  setColorPreset: (preset: ColorPreset) => void
  isSettingsOpen: boolean
  setIsSettingsOpen: (isOpen: boolean) => void
  stretchLevel: StretchLevel
  setStretchLevel: (level: StretchLevel) => void
}

const ThemeContext = createContext<ThemeContextType | undefined>(undefined)

export function ThemeProvider({ children }: { children: React.ReactNode }) {
  const [theme, setTheme] = useState<Theme>("light")
  const [direction, setDirection] = useState<Direction>("ltr")
  const [layout, setLayout] = useState<Layout>("default")
  const [colorPreset, setColorPreset] = useState<ColorPreset>("green")
  const [isSettingsOpen, setIsSettingsOpen] = useState(false)
  const [stretchLevel, setStretchLevel] = useState<StretchLevel>(0)

  // Apply theme to document
  useEffect(() => {
    const root = window.document.documentElement
    root.classList.remove("light", "dark")
    root.classList.add(theme)
  }, [theme])

  // Apply direction to document
  useEffect(() => {
    const html = document.documentElement
    html.setAttribute("dir", direction)
  }, [direction])

  // Apply color preset to document
  useEffect(() => {
    const root = window.document.documentElement
    root.classList.remove(
      "preset-green",
      "preset-purple",
      "preset-blue",
      "preset-orange",
      "preset-red",
      "preset-indigo",
    )
    root.classList.add(`preset-${colorPreset}`)
  }, [colorPreset])

  // Apply stretch level to document
  useEffect(() => {
    const root = window.document.documentElement
    root.classList.remove("stretch-0", "stretch-1", "stretch-2", "stretch-3", "stretch-4")
    root.classList.add(`stretch-${stretchLevel}`)
  }, [stretchLevel])

  return (
    <ThemeContext.Provider
      value={{
        theme,
        setTheme,
        direction,
        setDirection,
        layout,
        setLayout,
        colorPreset,
        setColorPreset,
        isSettingsOpen,
        setIsSettingsOpen,
        stretchLevel,
        setStretchLevel,
      }}
    >
      {children}
    </ThemeContext.Provider>
  )
}

export function useTheme() {
  const context = useContext(ThemeContext)
  if (context === undefined) {
    throw new Error("useTheme must be used within a ThemeProvider")
  }
  return context
}
