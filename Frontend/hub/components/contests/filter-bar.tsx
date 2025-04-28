"use client"

import { useState } from "react"
import { ChevronDownIcon } from "lucide-react"

export function FilterBar() {
  const [groupsOpen, setGroupsOpen] = useState(false)
  const [countriesOpen, setCountriesOpen] = useState(false)

  return (
    <div className="flex flex-wrap gap-4">
      <div className="relative">
        <button
          onClick={() => setGroupsOpen(!groupsOpen)}
          className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg"
        >
          <span>Groups</span>
          <ChevronDownIcon className="h-4 w-4" />
        </button>
        {groupsOpen && (
          <div className="absolute top-full left-0 mt-1 w-48 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg shadow-md z-10">
            <div className="p-2">
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">All Groups</div>
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">G5</div>
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">G6</div>
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">
                Remote Education
              </div>
            </div>
          </div>
        )}
      </div>

      <div className="relative">
        <button
          onClick={() => setCountriesOpen(!countriesOpen)}
          className="flex items-center gap-2 px-4 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg"
        >
          <span>Countries</span>
          <ChevronDownIcon className="h-4 w-4" />
        </button>
        {countriesOpen && (
          <div className="absolute top-full left-0 mt-1 w-48 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg shadow-md z-10">
            <div className="p-2">
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">All Countries</div>
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">Ethiopia</div>
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">Egypt</div>
              <div className="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded cursor-pointer">Sudan</div>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
