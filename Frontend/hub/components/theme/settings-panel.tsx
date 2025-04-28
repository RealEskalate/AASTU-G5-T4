"use client"

import { useState } from "react"
import { X, RotateCw, Maximize } from "lucide-react"
import { Button } from "@/components/ui/button"
import { useTheme } from "@/components/theme/theme-provider"
import type { StretchLevel } from "@/components/theme/theme-provider"

export function SettingsPanel() {
  const {
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
  } = useTheme()

  const [activeTab, setActiveTab] = useState<"mode" | "direction" | "layout" | "presets" | "stretch">("mode")

  const toggleFullscreen = () => {
    if (!document.fullscreenElement) {
      document.documentElement.requestFullscreen()
    } else {
      if (document.exitFullscreen) {
        document.exitFullscreen()
      }
    }
  }

  const handleStretchChange = (direction: "increase" | "decrease") => {
    if (direction === "increase" && stretchLevel < 4) {
      setStretchLevel((stretchLevel + 1) as StretchLevel)
    } else if (direction === "decrease" && stretchLevel > 0) {
      setStretchLevel((stretchLevel - 1) as StretchLevel)
    }
  }

  if (!isSettingsOpen) return null

  return (
    <div className="fixed top-0 right-0 h-screen w-80 bg-white dark:bg-slate-900 shadow-lg z-50 overflow-auto border-l dark:border-slate-700">
      <div className="flex justify-between items-center p-4 border-b dark:border-slate-700">
        <h2 className="text-lg font-semibold dark:text-white">Settings</h2>
        <div className="flex items-center gap-2">
          <Button variant="ghost" size="icon" onClick={() => window.location.reload()}>
            <RotateCw className="h-4 w-4" />
          </Button>
          <Button variant="ghost" size="icon" onClick={() => setIsSettingsOpen(false)}>
            <X className="h-4 w-4" />
          </Button>
        </div>
      </div>

      <div className="p-4">
        <div className="mb-6">
          <h3 className="text-sm font-medium mb-4 dark:text-white">Mode</h3>
          <div className="flex gap-4">
            <button
              className={`w-16 h-16 rounded-lg flex items-center justify-center ${
                theme === "light" ? "ring-2 ring-theme" : ""
              } border dark:border-slate-700`}
              onClick={() => setTheme("light")}
            >
              <div className="h-10 w-10 bg-white rounded-full border"></div>
            </button>
            <button
              className={`w-16 h-16 rounded-lg bg-slate-900 flex items-center justify-center ${
                theme === "dark" ? "ring-2 ring-theme" : ""
              } border dark:border-slate-700`}
              onClick={() => setTheme("dark")}
            >
              <div className="h-10 w-10 bg-slate-800 rounded-full border border-slate-700"></div>
            </button>
          </div>
        </div>

        <div className="mb-6">
          <h3 className="text-sm font-medium mb-4 dark:text-white">Direction</h3>
          <div className="flex gap-4">
            <button
              className={`w-16 h-16 rounded-lg border flex items-center justify-center ${
                direction === "ltr" ? "ring-2 ring-theme" : ""
              } dark:border-slate-700`}
              onClick={() => setDirection("ltr")}
            >
              <div className="flex flex-col items-start w-10">
                <div className="h-2 w-6 bg-slate-200 dark:bg-slate-700 rounded mb-1"></div>
                <div className="h-2 w-8 bg-slate-200 dark:bg-slate-700 rounded"></div>
              </div>
            </button>
            <button
              className={`w-16 h-16 rounded-lg border flex items-center justify-center ${
                direction === "rtl" ? "ring-2 ring-theme" : ""
              } dark:border-slate-700`}
              onClick={() => setDirection("rtl")}
            >
              <div className="flex flex-col items-end w-10">
                <div className="h-2 w-6 bg-slate-200 dark:bg-slate-700 rounded mb-1"></div>
                <div className="h-2 w-8 bg-slate-200 dark:bg-slate-700 rounded"></div>
              </div>
            </button>
          </div>
        </div>

        <div className="mb-6">
          <h3 className="text-sm font-medium mb-4 dark:text-white">Layout</h3>
          <div className="flex gap-4">
            <button
              className={`w-16 h-16 rounded-lg border flex items-center justify-center ${
                layout === "default" ? "ring-2 ring-theme" : ""
              } dark:border-slate-700`}
              onClick={() => setLayout("default")}
            >
              <div className="flex flex-col w-10 h-10">
                <div className="h-2 w-full bg-theme-bg dark:bg-theme-dark/30 rounded mb-1"></div>
                <div className="flex-1 flex gap-1">
                  <div className="w-2 bg-slate-200 dark:bg-slate-700 rounded"></div>
                  <div className="flex-1 bg-slate-100 dark:bg-slate-800 rounded"></div>
                </div>
              </div>
            </button>
            <button
              className={`w-16 h-16 rounded-lg border flex items-center justify-center ${
                layout === "compact" ? "ring-2 ring-theme" : ""
              } dark:border-slate-700`}
              onClick={() => setLayout("compact")}
            >
              <div className="flex flex-col w-10 h-10">
                <div className="h-2 w-full bg-slate-200 dark:bg-slate-700 rounded mb-1"></div>
                <div className="flex-1 flex gap-1">
                  <div className="w-2 bg-slate-200 dark:bg-slate-700 rounded"></div>
                  <div className="flex-1 bg-slate-100 dark:bg-slate-800 rounded"></div>
                </div>
              </div>
            </button>
          </div>
        </div>

        <div className="mb-6">
          <h3 className="text-sm font-medium mb-4 dark:text-white">Presets</h3>
          <div className="grid grid-cols-3 gap-4">
            <button
              className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                colorPreset === "green" ? "ring-2 ring-theme" : ""
              }`}
              onClick={() => setColorPreset("green")}
            >
              <div className="h-8 w-8 bg-green-500 rounded-full"></div>
            </button>
            <button
              className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                colorPreset === "purple" ? "ring-2 ring-theme" : ""
              }`}
              onClick={() => setColorPreset("purple")}
            >
              <div className="h-8 w-8 bg-purple-500 rounded-full"></div>
            </button>
            <button
              className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                colorPreset === "blue" ? "ring-2 ring-theme" : ""
              }`}
              onClick={() => setColorPreset("blue")}
            >
              <div className="h-8 w-8 bg-blue-500 rounded-full"></div>
            </button>
            <button
              className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                colorPreset === "orange" ? "ring-2 ring-theme" : ""
              }`}
              onClick={() => setColorPreset("orange")}
            >
              <div className="h-8 w-8 bg-orange-500 rounded-full"></div>
            </button>
            <button
              className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                colorPreset === "red" ? "ring-2 ring-theme" : ""
              }`}
              onClick={() => setColorPreset("red")}
            >
              <div className="h-8 w-8 bg-red-500 rounded-full"></div>
            </button>
            <button
              className={`w-12 h-12 rounded-lg flex items-center justify-center ${
                colorPreset === "indigo" ? "ring-2 ring-theme" : ""
              }`}
              onClick={() => setColorPreset("indigo")}
            >
              <div className="h-8 w-8 bg-indigo-500 rounded-full"></div>
            </button>
          </div>
        </div>

        <div className="mb-6">
          <h3 className="text-sm font-medium mb-4 dark:text-white">Stretch</h3>
          <div
            className="flex gap-4 justify-center border dark:border-slate-700 rounded-lg p-2 cursor-pointer"
            onClick={() => handleStretchChange("increase")}
          >
            <span className="text-lg dark:text-white">&lt;</span>
            <span className="text-lg dark:text-white">&gt;</span>
          </div>
          <div className="mt-2 text-center text-xs text-slate-500 dark:text-slate-400">
            Stretch Level: {stretchLevel}
          </div>
        </div>

        <Button onClick={toggleFullscreen} className="w-full mt-4 bg-theme hover:bg-theme-dark text-white">
          <Maximize className="h-4 w-4 mr-2" />
          Fullscreen
        </Button>
      </div>
    </div>
  )
}
