import { Button } from "@/components/ui/button"

export function ProfileTabs({ activeTab, setActiveTab }: { activeTab: string; setActiveTab: (tab: string) => void }) {
  const tabs = ["profile", "problems", "submissions", "contests"]

  return (
    <div className="flex border-b mb-8 overflow-x-auto dark:border-slate-700">
      {tabs.map((tab) => (
        <Button
          key={tab}
          variant="ghost"
          className={`text-slate-${activeTab === tab ? "900 dark:text-white" : "500 dark:text-slate-400"} ${
            activeTab === tab ? "border-b-2 border-theme" : ""
          } rounded-none`}
          onClick={() => setActiveTab(tab)}
        >
          {tab.charAt(0).toUpperCase() + tab.slice(1)}
        </Button>
      ))}
    </div>
  )
}
