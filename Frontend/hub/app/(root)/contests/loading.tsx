import { Skeleton } from "@/components/ui/skeleton"

export default function ContestsLoading() {
  return (
    <div>
      <div className="mb-6">
        <Skeleton className="h-6 w-48 mb-4" />
        <div className="flex gap-4">
          <Skeleton className="h-10 w-32" />
          <Skeleton className="h-10 w-32" />
        </div>
      </div>

      {[1, 2, 3, 4, 5].map((i) => (
        <div
          key={i}
          className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 mb-4 border border-slate-200 dark:border-slate-700"
        >
          <Skeleton className="h-6 w-3/4 mb-3" />
          <div className="flex gap-4">
            <Skeleton className="h-4 w-24" />
            <Skeleton className="h-4 w-32" />
          </div>
        </div>
      ))}
    </div>
  )
}
