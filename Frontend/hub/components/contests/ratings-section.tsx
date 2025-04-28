"use client"

export function RatingsSection() {
  // Dummy data for top rated users
  const topUsers = [
    { id: 1, name: "Amro Adil Mohamedahmed Salman", rating: 2683, group: "G5A Student" },
    { id: 2, name: "Marouane BENBETKA", rating: 2405, group: "G5C Student" },
    { id: 3, name: "Abel Gebeyehu", rating: 2284, group: "G5C Student" },
    { id: 4, name: "Kenenisa Alemayehu", rating: 2256, group: "G6E Head" },
    { id: 5, name: "Merwan", rating: 2228, group: "G5A Student" },
    { id: 6, name: "mohamed hossam", rating: 2190, group: "G6D Student" },
  ]

  return (
    <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 border border-slate-200 dark:border-slate-700">
      <div className="flex justify-between items-center mb-4">
        <h3 className="font-medium">Ratings</h3>
        <button className="text-sm text-purple-600 dark:text-purple-400 font-medium">Visual</button>
      </div>
      <p className="text-sm text-slate-600 dark:text-slate-400 mb-4">There are 1294 users with ratings</p>

      <div className="space-y-4">
        {topUsers.map((user) => (
          <div key={user.id} className="flex items-center justify-between">
            <div className="flex items-center">
              <div className="w-6 h-6 bg-slate-200 dark:bg-slate-700 rounded-full flex items-center justify-center text-xs mr-2">
                {user.id}
              </div>
              <div className="h-10 w-10 rounded-full bg-slate-200 dark:bg-slate-700 mr-3"></div>
              <div>
                <p className="font-medium text-sm">{user.name}</p>
                <p className="text-xs text-slate-600 dark:text-slate-400">{user.group}</p>
              </div>
            </div>
            <div className="font-medium">{user.rating}</div>
          </div>
        ))}
      </div>
    </div>
  )
}
