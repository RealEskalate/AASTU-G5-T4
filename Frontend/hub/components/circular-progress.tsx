interface CircularProgressProps {
    title: string
    value: number
    total: number
    color?: string
    size?: "sm" | "md" | "lg"
  }
  
  export default function CircularProgress({ title, value, total, color = "blue", size = "md" }: CircularProgressProps) {
    const percentage = Math.round((value / total) * 100) || 0
    const radius = size === "sm" ? 40 : size === "md" ? 60 : 80
    const strokeWidth = size === "sm" ? 6 : size === "md" ? 8 : 10
    const circumference = 2 * Math.PI * radius
    const strokeDashoffset = circumference - (percentage / 100) * circumference
  
    const colorClasses = {
      blue: "stroke-blue-500",
      yellow: "stroke-yellow-400",
      green: "stroke-green-500",
      red: "stroke-red-500",
      gray: "stroke-gray-300",
    }
  
    const colorClass = colorClasses[color as keyof typeof colorClasses] || colorClasses.blue
  
    return (
      <div className="flex flex-col items-center justify-center">
        <div className="relative">
          <svg
            width={(radius + strokeWidth) * 2}
            height={(radius + strokeWidth) * 2}
            viewBox={`0 0 ${(radius + strokeWidth) * 2} ${(radius + strokeWidth) * 2}`}
            className="transform -rotate-90"
          >
            <circle
              cx={radius + strokeWidth}
              cy={radius + strokeWidth}
              r={radius}
              fill="transparent"
              stroke="#f3f4f6"
              strokeWidth={strokeWidth}
            />
            <circle
              cx={radius + strokeWidth}
              cy={radius + strokeWidth}
              r={radius}
              fill="transparent"
              stroke="currentColor"
              strokeWidth={strokeWidth}
              strokeDasharray={circumference}
              strokeDashoffset={strokeDashoffset}
              className={colorClass}
              strokeLinecap="round"
            />
          </svg>
          <div className="absolute inset-0 flex flex-col items-center justify-center text-center">
            <div className="text-gray-700 font-medium">{title}</div>
            <div className="text-2xl font-bold">{value}</div>
          </div>
        </div>
      </div>
    )
  }
  
  