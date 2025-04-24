import { ChevronDown } from "lucide-react"

interface GroupUpsolvingTabProps {
  groupId: string
}

export function GroupUpsolvingTab({ groupId }: GroupUpsolvingTabProps) {
  // Mock data for upsolving
  const upsolvingData = {
    summary: {
      exercises: 126,
      solved: 44,
      completion: "35%",
      available: 82,
    },
    students: [
      { id: "1", name: "Yordanos", solved: 74, completion: "59%", available: 52 },
      { id: "2", name: "Samrawit", solved: 73, completion: "58%", available: 53 },
      { id: "3", name: "Ikram", solved: 71, completion: "56%", available: 55 },
      { id: "4", name: "Mahlet", solved: 64, completion: "51%", available: 62 },
      { id: "5", name: "Natnael", solved: 59, completion: "47%", available: 67 },
    ],
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-lg font-medium dark:text-white">Contest Upsolving Completion</h3>
      </div>

      <div className="mb-8">
        <h4 className="text-lg font-medium dark:text-white mb-4">Team Completion</h4>
        <div className="relative h-8 bg-red-500 rounded-full mb-2 overflow-hidden">
          <div
            className="absolute inset-0 bg-gradient-to-r from-red-500 to-yellow-500"
            style={{ width: upsolvingData.summary.completion }}
          ></div>
        </div>
        <div className="text-sm text-center dark:text-slate-300">
          {upsolvingData.summary.exercises} Exercises | {upsolvingData.summary.solved} Solved (average) |{" "}
          {upsolvingData.summary.completion} Completion | {upsolvingData.summary.available} Available (average)
        </div>

        <div className="flex justify-end mb-2">
          <div className="flex items-center gap-2">
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 rounded-full bg-green-500"></div>
              <span className="text-xs dark:text-slate-300">Good</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 rounded-full bg-yellow-500"></div>
              <span className="text-xs dark:text-slate-300">Okay</span>
            </div>
            <div className="flex items-center gap-1">
              <div className="w-3 h-3 rounded-full bg-red-500"></div>
              <span className="text-xs dark:text-slate-300">Bad</span>
            </div>
          </div>
        </div>

        <div className="bg-white dark:bg-slate-800 rounded-lg p-4 mb-4">
          <div className="flex justify-between items-center mb-2">
            <h5 className="font-medium dark:text-white">Detail Team Completion</h5>
            <ChevronDown className="h-5 w-5 text-slate-500 dark:text-slate-400" />
          </div>

          <div className="space-y-4">
            {upsolvingData.students.map((student) => (
              <div key={student.id} className="flex items-center gap-4">
                <div className="w-8 h-8 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center">
                  <img src="/placeholder.svg?height=32&width=32" alt={student.name} className="w-8 h-8 rounded-full" />
                </div>
                <div className="flex-1">
                  <div className="flex justify-between text-sm dark:text-slate-300 mb-1">
                    <span>{student.name}</span>
                    <span>
                      {student.solved} Solved | {student.completion} Completion | {student.available} Available
                    </span>
                  </div>
                  <div className="h-2 bg-slate-200 dark:bg-slate-700 rounded-full overflow-hidden">
                    <div
                      className={`h-full ${Number.parseInt(student.completion) > 50 ? "bg-yellow-500" : "bg-red-500"}`}
                      style={{ width: student.completion }}
                    ></div>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
