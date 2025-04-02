interface DifficultyBadgeProps {
    difficulty: "Easy" | "Medium" | "Hard"
  }
  
  export default function DifficultyBadge({ difficulty }: DifficultyBadgeProps) {
    const colorClasses = {
      Easy: "bg-green-100 text-green-800",
      Medium: "bg-yellow-100 text-yellow-800",
      Hard: "bg-red-100 text-red-800",
    }
  
    return <span className={`px-2 py-1 rounded-md text-xs font-medium ${colorClasses[difficulty]}`}>{difficulty}</span>
  }
  
  