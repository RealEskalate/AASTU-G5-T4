import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { GroupAttendanceTab } from "@/components/groups/statistics/group-attendance-tab"
import { GroupConsistencyTab } from "@/components/groups/statistics/group-consistency-tab"
import { GroupCompletionTab } from "@/components/groups/statistics/group-completion-tab"
import { GroupExerciseTab } from "@/components/groups/statistics/group-exercise-tab"
import { GroupUpsolvingTab } from "@/components/groups/statistics/group-upsolving-tab"
import { GroupDivisionsTab } from "@/components/groups/statistics/group-divisions-tab"

interface GroupStatisticsTabProps {
  groupId: string
}

export function GroupStatisticsTab({ groupId }: GroupStatisticsTabProps) {
  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div className="grid grid-cols-3 gap-6">
          <div>
            <div className="text-sm text-slate-500 dark:text-slate-400">Time Spent</div>
            <div className="text-2xl font-bold dark:text-white">246,672</div>
          </div>
          <div>
            <div className="text-sm text-slate-500 dark:text-slate-400">Solved Problems</div>
            <div className="text-2xl font-bold dark:text-white">731</div>
          </div>
          <div>
            <div className="text-sm text-slate-500 dark:text-slate-400">Avg. Rating</div>
            <div className="text-2xl font-bold dark:text-white">1,220</div>
          </div>
        </div>

        <div className="w-64 h-64">
          {/* Radar chart would go here - simplified for now */}
          <div className="w-full h-full bg-slate-100 dark:bg-slate-800 rounded-full flex items-center justify-center">
            <div className="text-center">
              <div className="text-sm text-slate-500 dark:text-slate-400">Performance</div>
              <div className="text-xl font-bold text-theme">Good</div>
            </div>
          </div>
        </div>
      </div>

      <Tabs defaultValue="attendance">
        <TabsList className="w-full border-b dark:border-slate-700 bg-transparent mb-6">
          <TabsTrigger
            value="attendance"
            className="rounded-none data-[state=active]:border-b-2 data-[state=active]:border-theme"
          >
            Attendance
          </TabsTrigger>
          <TabsTrigger
            value="consistency"
            className="rounded-none data-[state=active]:border-b-2 data-[state=active]:border-theme"
          >
            Consistency
          </TabsTrigger>
          <TabsTrigger
            value="completion"
            className="rounded-none data-[state=active]:border-b-2 data-[state=active]:border-theme"
          >
            Completion
          </TabsTrigger>
          <TabsTrigger
            value="exercise"
            className="rounded-none data-[state=active]:border-b-2 data-[state=active]:border-theme"
          >
            Exercise
          </TabsTrigger>
          <TabsTrigger
            value="upsolving"
            className="rounded-none data-[state=active]:border-b-2 data-[state=active]:border-theme"
          >
            Upsolving
          </TabsTrigger>
          <TabsTrigger
            value="divisions"
            className="rounded-none data-[state=active]:border-b-2 data-[state=active]:border-theme"
          >
            Divisions
          </TabsTrigger>
        </TabsList>

        <TabsContent value="attendance">
          <GroupAttendanceTab groupId={groupId} />
        </TabsContent>

        <TabsContent value="consistency">
          <GroupConsistencyTab groupId={groupId} />
        </TabsContent>

        <TabsContent value="completion">
          <GroupCompletionTab groupId={groupId} />
        </TabsContent>

        <TabsContent value="exercise">
          <GroupExerciseTab groupId={groupId} />
        </TabsContent>

        <TabsContent value="upsolving">
          <GroupUpsolvingTab groupId={groupId} />
        </TabsContent>

        <TabsContent value="divisions">
          <GroupDivisionsTab groupId={groupId} />
        </TabsContent>
      </Tabs>
    </div>
  )
}
