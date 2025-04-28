import { ChevronDown } from "lucide-react"

interface GroupCompletionTabProps {
  groupId: string
}

export function GroupCompletionTab({ groupId }: GroupCompletionTabProps) {
  // Mock data for completion
  const completionData = {
    summary: {
      exercises: 224,
      solved: 159,
      completion: "71%",
      available: 65,
    },
    students: [
      { id: "1", name: "Simret", solved: 183, completion: "82%", available: 41 },
      { id: "2", name: "Mahlet", solved: 179, completion: "80%", available: 45 },
      { id: "3", name: "Nebiyou", solved: 178, completion: "79%", available: 46 },
      { id: "4", name: "Matiyas", solved: 175, completion: "78%", available: 49 },
      { id: "5", name: "Nahom", solved: 173, completion: "77%", available: 51 },
    ],
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-lg font-medium dark:text-white">Exercise Completion Summary</h3>
        <div className="flex items-center gap-2">
          <span className="text-sm text-slate-500 dark:text-slate-400">Progress</span>
        </div>
      </div>

      <div className="mb-8">
        <h4 className="text-lg font-medium dark:text-white mb-4">Team Completion</h4>
        <div className="relative h-8 bg-yellow-500 rounded-full mb-2 overflow-hidden">
          <div
            className="absolute inset-0 bg-gradient-to-r from-yellow-500 to-green-500"
            style={{ width: completionData.summary.completion }}
          ></div>
        </div>
        <div className="text-sm text-center dark:text-slate-300">
          {completionData.summary.exercises} Exercises | {completionData.summary.solved} Solved (average) |{" "}
          {completionData.summary.completion} Completion | {completionData.summary.available} Available (average)
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
            {completionData.students.map((student) => (
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
                    <div className="h-full bg-green-500" style={{ width: student.completion }}></div>
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
