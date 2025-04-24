import { Button } from "@/components/ui/button"

export function CompanionNotification() {
  return (
    <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6 dark:bg-yellow-900/20 dark:border-yellow-800">
      <div className="flex justify-between items-center">
        <div className="flex items-start gap-2">
          <div className="mt-1">🛠️</div>
          <div>
            <h3 className="font-medium dark:text-white">Companion</h3>
            <p className="text-sm text-slate-600 dark:text-slate-300">
              A2SV Companion is not detected. The extension will help you submit problems you solve on leetcode and
              codeforces. Please install the extension and reload this page.
            </p>
          </div>
        </div>
        <Button className="bg-green-500 hover:bg-green-600 text-white whitespace-nowrap">Install</Button>
      </div>
    </div>
  )
}
