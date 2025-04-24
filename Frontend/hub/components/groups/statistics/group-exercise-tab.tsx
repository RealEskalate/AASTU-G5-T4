interface GroupExerciseTabProps {
  groupId: string
}

export function GroupExerciseTab({ groupId }: GroupExerciseTabProps) {
  // Mock data for exercises
  const exerciseData = {
    summary: {
      total: 224,
    },
    problems: [
      { id: "1", title: "Number of Parallelograms", completion: "4%" },
      { id: "2", title: "Simple Subset", completion: "4%" },
      { id: "3", title: "Bitwise XOR of All Pairings", completion: "9%" },
      { id: "4", title: "Different Ways to Add Parentheses", completion: "8%" },
      { id: "5", title: "Populating Next Right Pointers", completion: "8%" },
      { id: "6", title: "Cousins in Binary Tree II", completion: "17%" },
    ],
    students: [
      {
        id: "1",
        name: "Simret",
        rank: 1,
        score: "183/183",
        times: {
          "1": "10 min",
          "3": "10 min",
          "5": "10 min",
        },
      },
      {
        id: "2",
        name: "Mahlet",
        rank: 2,
        score: "179/179",
        times: {
          "1": "10 min",
          "6": "44 min",
        },
      },
      {
        id: "3",
        name: "Nebiyou",
        rank: 3,
        score: "178/178",
        times: {
          "2": "16 min",
          "5": "10 min",
        },
      },
      {
        id: "4",
        name: "Matiyas",
        rank: 4,
        score: "175/175",
        times: {
          "3": "30 min",
          "4": "25 min",
          "5": "35 min",
        },
      },
    ],
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-lg font-medium dark:text-white">Exercise Summary</h3>
        <div className="flex items-center gap-2">
          <span className="text-sm text-slate-500 dark:text-slate-400">Progress</span>
        </div>
      </div>

      <div className="overflow-x-auto">
        <table className="w-full min-w-[800px]">
          <thead>
            <tr className="border-b dark:border-slate-700">
              <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">#</th>
              <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Name</th>
              {exerciseData.problems.map((problem) => (
                <th
                  key={problem.id}
                  className="py-3 px-2 text-center font-medium text-xs text-slate-600 dark:text-slate-300 whitespace-normal max-w-[100px]"
                >
                  {problem.title}
                  <div className="text-[10px] text-slate-500">
                    <span className="inline-block w-2 h-2 rounded-full bg-red-500 mr-1"></span>
                    <span>Nov 24 • {problem.completion}</span>
                  </div>
                </th>
              ))}
            </tr>
          </thead>
          <tbody>
            {exerciseData.students.map((student) => (
              <tr key={student.id} className="border-b dark:border-slate-700">
                <td className="py-3 px-4 text-left text-sm dark:text-slate-300">{student.rank}</td>
                <td className="py-3 px-4 text-left text-sm dark:text-slate-300">
                  <div className="flex items-center gap-2">
                    <img
                      src="/placeholder.svg?height=24&width=24"
                      alt={student.name}
                      className="w-6 h-6 rounded-full"
                    />
                    <span>{student.name}</span>
                    <span className="text-xs text-slate-500">({student.score})</span>
                  </div>
                </td>
                {exerciseData.problems.map((problem) => (
                  <td key={problem.id} className="py-3 px-2 text-center">
                    {student.times[problem.id] ? (
                      <div className="bg-red-500 text-white text-xs py-1 px-2 rounded-md">
                        <span className="inline-block w-2 h-2 rounded-full bg-white mr-1"></span>
                        {student.times[problem.id]}
                      </div>
                    ) : null}
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
