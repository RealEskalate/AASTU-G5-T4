import { Skeleton } from "@/components/ui/skeleton"

export default function ContestDetailLoading() {
  return (
    <div>
      <Skeleton className="h-10 w-1/2 mb-6" />

      <div className="mb-6">
        <Skeleton className="h-10 w-48" />
      </div>

      <Skeleton className="h-64 w-full" />
    </div>
  )
}
