import { ContestList } from "@/components/contests/contest-list"
import { FilterBar } from "@/components/contests/filter-bar"
import { RatingsSection } from "@/components/contests/ratings-section"

export default function ContestsPage() {
  return (
    <div className="container mx-auto px-4 py-6">
      <h1 className="text-2xl font-bold mb-2">Contests</h1>
      <p className="text-slate-600 dark:text-slate-400 mb-6">Ratings & contests</p>

      <div className="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <div className="lg:col-span-2">
          <FilterBar />
          <div className="mt-6">
            <ContestList /> {/* Ensure ContestList uses useGetContestsQuery */}
          </div>
        </div>
        <div>
          <RatingsSection />
        </div>
      </div>
    </div>
  )
}
