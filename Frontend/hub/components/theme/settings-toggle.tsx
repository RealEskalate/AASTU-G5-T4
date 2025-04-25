"use client"

import { Settings } from "lucide-react"
import { Button } from "@/components/ui/button"
import { useTheme } from "@/components/theme/theme-provider"

export function SettingsToggle() {
  const { isSettingsOpen, setIsSettingsOpen, direction } = useTheme()

  return (
    <Button
      variant="outline"
      size="icon"
      className={`settings-toggle fixed bottom-4 ${
        direction === "ltr" ? "right-4" : "left-4"
      } z-50 rounded-full h-10 w-10 shadow-lg bg-white dark:bg-slate-800 dark:border-slate-700`}
      onClick={() => setIsSettingsOpen(!isSettingsOpen)}
    >
      <Settings className="h-5 w-5 dark:text-white" />
    </Button>
  )
}
