import Image from "next/image"

interface StatsCardProps {
  title: string
  value: string | number
  percentage: string
  isPositive?: boolean
}

export default function StatsCard({ title, value, percentage, isPositive = true }: StatsCardProps) {
  return (
    <div className="bg-white rounded-lg p-4 shadow-sm border">
      <div className="flex justify-between items-center mb-2">
        <span className="text-sm text-gray-500">{title}</span>
        <span
          className={`text-xs ${isPositive ? "text-green-600 bg-green-50" : "text-red-600 bg-red-50"} px-2 py-0.5 rounded-full flex items-center`}
        >
          <span className="mr-1">{isPositive ? "+" : ""}</span>
          {percentage}
        </span>
      </div>
      <div className="flex justify-between items-end">
        <span className="text-3xl font-bold">{value}</span>
        <div className="h-8 w-16">
          <Image src="/placeholder.svg?height=32&width=64" alt="Chart" width={64} height={32} />
        </div>
      </div>
    </div>
  )
}

