export function MiniBarChart({
    data = [5, 10, 15, 20, 15, 10, 5],
    color = "blue",
  }: { data?: number[]; color?: "blue" | "green" | "red" }) {
    const max = Math.max(...data)
  
    const getColor = () => {
      switch (color) {
        case "green":
          return "bg-green-500"
        case "red":
          return "bg-red-500"
        default:
          return "bg-blue-500"
      }
    }
  
    return (
      <div className="flex items-end h-10 gap-[2px]">
        {data.map((value, index) => (
          <div key={index} className={`w-1 ${getColor()} rounded-sm`} style={{ height: `${(value / max) * 100}%` }} />
        ))}
      </div>
    )
  }
  