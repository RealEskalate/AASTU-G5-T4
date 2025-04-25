import { cn } from "@/lib/utils"

type DifficultyLevel = "easy" | "medium" | "hard" | "expert"

interface DifficultyBadgeProps {
  level: DifficultyLevel
  size?: "sm" | "md" | "lg"
  showLabel?: boolean
  className?: string
}

export function DifficultyBadge({ level, size = "md", showLabel = true, className }: DifficultyBadgeProps) {
  const getColor = () => {
    switch (level) {
      case "easy":
        return "bg-green-100 text-green-800"
      case "medium":
        return "bg-yellow-100 text-yellow-800"
      case "hard":
        return "bg-orange-100 text-orange-800"
      case "expert":
        return "bg-red-100 text-red-800"
      default:
        return "bg-slate-100 text-slate-800"
    }
  }

  const getSize = () => {
    switch (size) {
      case "sm":
        return "text-xs px-2 py-0.5"
      case "lg":
        return "text-sm px-3 py-1"
      default:
        return "text-xs px-2.5 py-0.5"
    }
  }

  return (
    <span className={cn("inline-flex items-center rounded-full font-medium", getColor(), getSize(), className)}>
      {showLabel ? level.charAt(0).toUpperCase() + level.slice(1) : ""}
    </span>
  )
}
