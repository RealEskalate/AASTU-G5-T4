interface GroupDivisionsTabProps {
  groupId: string
}

export function GroupDivisionsTab({ groupId }: GroupDivisionsTabProps) {
  // Mock data for divisions
  const divisionsData = {
    divisions: [
      {
        id: "1",
        name: "Div 1",
        count: 0,
        students: [],
      },
      {
        id: "2",
        name: "Div 2",
        count: 5,
        students: [
          { id: "1", name: "Dawit Sema" },
          { id: "2", name: "Eyerusalem Bezu Betru" },
          { id: "3", name: "Adane Moges Erdachew" },
          { id: "4", name: "Yordanos Legesse" },
          { id: "5", name: "Natnael Worku Kelkile" },
        ],
      },
      {
        id: "3",
        name: "Div 3",
        count: 23,
        students: [
          { id: "6", name: "Abenezer Mulugeta Woldesenbet" },
          { id: "7", name: "Samrawit Gebremaryam Bahta" },
          { id: "8", name: "Solome Getachew Abebe" },
          { id: "9", name: "Sefina Kamile Abrar" },
          { id: "10", name: "Matiyas Woldemariam Gebresenbet" },
          { id: "11", name: "Haweten Girma Guluma" },
          { id: "12", name: "Daniel Asfaw Teklemariam" },
          { id: "13", name: "Mihret Tekalign" },
          { id: "14", name: "Ikram Awol Shifa" },
        ],
      },
    ],
  }

  return (
    <div>
      <div className="flex justify-between items-center mb-6">
        <h3 className="text-lg font-medium dark:text-white">Divisions</h3>
        <div className="flex items-center gap-2">
          <select className="border rounded-md px-3 py-2 bg-transparent dark:bg-slate-800 dark:border-slate-700 dark:text-white">
            <option>Group</option>
            <option>All</option>
          </select>
        </div>
      </div>

      <div className="space-y-4">
        {divisionsData.divisions.map((division) => (
          <div key={division.id} className="bg-white dark:bg-slate-800 rounded-lg p-4">
            <h4 className="text-lg font-medium dark:text-white mb-2">
              {division.name} <span className="text-sm text-slate-500">({division.count})</span>
            </h4>

            {division.students.length > 0 ? (
              <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-2">
                {division.students.map((student) => (
                  <div key={student.id} className="flex items-center gap-2 p-2">
                    <div className="w-8 h-8 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center">
                      <img
                        src="/placeholder.svg?height=32&width=32"
                        alt={student.name}
                        className="w-8 h-8 rounded-full"
                      />
                    </div>
                    <span className="text-sm dark:text-slate-300">{student.name}</span>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-sm text-slate-500 dark:text-slate-400">No students in this division</p>
            )}
          </div>
        ))}
      </div>
    </div>
  )
}
