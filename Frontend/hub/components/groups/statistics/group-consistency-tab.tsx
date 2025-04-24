interface GroupConsistencyTabProps {
  groupId: string
}

export function GroupConsistencyTab({ groupId }: GroupConsistencyTabProps) {
  // Mock data for consistency
  const consistencyData = {
    students: [
      { id: "1", name: "Abenezer", streak: "0/24", percentage: "84%", days: Array(30).fill(false) },
      { id: "2", name: "Samrawit", streak: "0/102", percentage: "84%", days: Array(30).fill(false) },
      { id: "3", name: "Simret", streak: "0/109", percentage: "83%", days: Array(30).fill(false) },
      { id: "4", name: "Eyerusalem", streak: "0/136", percentage: "78%", days: Array(30).fill(false) },
      { id: "5", name: "Mahlet", streak: "0/236", percentage: "80%", days: Array(30).fill(false) },
    ],
  }

  // Generate dates for the last 30 days
  const days = Array.from({ length: 30 }, (_, i) => 15.4 - i * 0.5).reverse()

  return (
    <div>
      <div className="flex justify-between items-center mb-4">
        <h3 className="text-lg font-medium dark:text-white">Consistency Summary</h3>
        <div className="flex items-center gap-2">
          <input type="checkbox" id="daily-streak" className="mr-1" />
          <label htmlFor="daily-streak" className="text-sm text-slate-500 dark:text-slate-400">
            Daily problem streak
          </label>
        </div>
      </div>

      <div className="bg-white dark:bg-slate-800 rounded-lg overflow-auto">
        <table className="w-full">
          <thead>
            <tr className="border-b dark:border-slate-700">
              <th className="py-2 px-4 text-center font-medium text-sm text-slate-600 dark:text-slate-300">
                399
                <br />
                <span className="text-xs">day/month</span>
              </th>
              {days.map((day, i) => (
                <th
                  key={i}
                  className="py-2 px-1 text-center font-medium text-xs text-slate-600 dark:text-slate-300 whitespace-nowrap"
                >
                  {day.toFixed(1)}
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {consistencyData.students.map((student) => (
              <tr key={student.id} className="border-b dark:border-slate-700">
                <td className="py-2 px-4 text-left text-sm dark:text-slate-300 whitespace-nowrap">
                  <div className="flex items-center gap-2">
                    <div className="w-2 h-2 rounded-full bg-slate-300"></div>
                    <span>{student.streak}</span>
                    <img
                      src="/placeholder.svg?height=24&width=24"
                      alt={student.name}
                      className="w-6 h-6 rounded-full"
                    />
                    <span>{student.name}</span>
                    <span className="text-xs text-slate-500">({student.percentage})</span>
                  </div>
                </td>
                {student.days.map((solved, i) => (
                  <td key={i} className="py-1 px-1 text-center">
                    <div className="w-6 h-6 mx-auto bg-red-500 rounded-sm"></div>
                  </td>
                ))}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  )
}
