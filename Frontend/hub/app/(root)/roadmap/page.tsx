"use client"

import { useState } from "react"
import Link from "next/link"
import { ChevronDown, ChevronUp, ExternalLink } from "lucide-react"
import { CircularProgress } from "@/components/circular-progress"
import { DataTable } from "@/components/data-table"
import { DifficultyBadge } from "@/components/difficulty-badge"

// Mock data for roadmap topics
const roadmapTopicsData = [
  {
    id: "math",
    name: "Math",
    description:
      "Embark on a journey of mathematical wonders, where numbers dance and equations weave the fabric of the universe.",
    progress: 12,
    recommended: true,
    resources: [
      {
        id: "khan-academy",
        name: "Khan Academy - Math",
        url: "https://www.khanacademy.org/math",
      },
      {
        id: "brilliant",
        name: "Brilliant.org - Math and Science Enrichment",
        url: "https://brilliant.org/",
      },
    ],
    problems: [
      {
        id: "p1",
        difficulty: "easy",
        name: "Thearte Square",
        tag: "Math",
        solved: "-",
        added: "1y",
        vote: 0,
        link: "#",
      },
      {
        id: "p2",
        difficulty: "easy",
        name: "Domino Piling",
        tag: "Math",
        solved: "-",
        added: "1y",
        vote: 0,
        link: "#",
      },
      {
        id: "p3",
        difficulty: "medium",
        name: "Count Number of Distinct Integers After Reverse Operations",
        tag: "Math",
        solved: "-",
        added: "1y",
        vote: 0,
        link: "#",
      },
      {
        id: "p4",
        difficulty: "easy",
        name: "Arithmetic Operator",
        tag: "Math",
        solved: "-",
        added: "1y",
        vote: 0,
        link: "#",
      },
      {
        id: "p5",
        difficulty: "easy",
        name: "Division",
        tag: "Math",
        solved: "-",
        added: "1y",
        vote: 0,
        link: "#",
      },
    ],
  },
  {
    id: "array",
    name: "Array",
    description: "Master the fundamental data structure that powers countless algorithms and solutions.",
    progress: 62,
    recommended: false,
    resources: [
      {
        id: "array-resource-1",
        name: "Arrays in Computer Science",
        url: "https://www.geeksforgeeks.org/array-data-structure/",
      },
      {
        id: "array-resource-2",
        name: "Array Manipulation Techniques",
        url: "https://leetcode.com/explore/learn/card/fun-with-arrays/",
      },
    ],
    problems: [
      {
        id: "a1",
        difficulty: "easy",
        name: "Two Sum",
        tag: "Array",
        solved: "✓",
        added: "1y",
        vote: 5,
        link: "#",
      },
      {
        id: "a2",
        difficulty: "medium",
        name: "Container With Most Water",
        tag: "Array",
        solved: "✓",
        added: "1y",
        vote: 3,
        link: "#",
      },
      {
        id: "a3",
        difficulty: "medium",
        name: "3Sum",
        tag: "Array",
        solved: "✓",
        added: "1y",
        vote: 2,
        link: "#",
      },
    ],
  },
  {
    id: "string",
    name: "String",
    description: "Explore the versatile world of text manipulation and pattern matching algorithms.",
    progress: 32,
    recommended: false,
    resources: [
      {
        id: "string-resource-1",
        name: "String Algorithms",
        url: "https://www.geeksforgeeks.org/string-data-structure/",
      },
    ],
    problems: [
      {
        id: "s1",
        difficulty: "easy",
        name: "Valid Anagram",
        tag: "String",
        solved: "✓",
        added: "1y",
        vote: 2,
        link: "#",
      },
      {
        id: "s2",
        difficulty: "medium",
        name: "Longest Substring Without Repeating Characters",
        tag: "String",
        solved: "-",
        added: "1y",
        vote: 4,
        link: "#",
      },
    ],
  },
  {
    id: "sorting",
    name: "Sorting",
    description: "Learn the art of arranging elements in a specific order, a fundamental skill in programming.",
    progress: 0,
    recommended: false,
    resources: [
      {
        id: "sorting-resource-1",
        name: "Sorting Algorithms",
        url: "https://www.geeksforgeeks.org/sorting-algorithms/",
      },
    ],
    problems: [
      {
        id: "sort1",
        difficulty: "easy",
        name: "Sort Colors",
        tag: "Sorting",
        solved: "-",
        added: "1y",
        vote: 1,
        link: "#",
      },
      {
        id: "sort2",
        difficulty: "medium",
        name: "Merge Intervals",
        tag: "Sorting",
        solved: "-",
        added: "1y",
        vote: 3,
        link: "#",
      },
    ],
  },
]

export default function RoadmapPage() {
  const [expandedSections, setExpandedSections] = useState<Record<string, { resources: boolean; problems: boolean }>>(
    {},
  )

  const toggleSection = (topicId: string, section: "resources" | "problems") => {
    setExpandedSections((prev) => {
      const topicState = prev[topicId] || { resources: false, problems: false }
      return {
        ...prev,
        [topicId]: {
          ...topicState,
          [section]: !topicState[section],
        },
      }
    })
  }

  // Column definitions for problems
  const problemsColumns = [
    {
      key: "difficulty",
      title: "Diff.",
      render: (value: string) => <DifficultyBadge level={value as any} size="sm" />,
    },
    {
      key: "name",
      title: "Name",
    },
    {
      key: "tag",
      title: "Tag",
      align: "right" as const,
    },
    {
      key: "solved",
      title: "Solved",
      align: "right" as const,
    },
    {
      key: "added",
      title: "Added",
      align: "right" as const,
    },
    {
      key: "vote",
      title: "Vote",
      align: "right" as const,
    },
    {
      key: "link",
      title: "Link",
      align: "right" as const,
      render: () => (
        <Link href="#" className="text-blue-500 hover:text-blue-700">
          <ExternalLink className="h-4 w-4" />
        </Link>
      ),
    },
  ]

  return (
    <div className="p-4 md:p-6 max-w-5xl mx-auto">
      <div className="mb-6">
        <h1 className="text-2xl font-bold dark:text-white">Roadmap</h1>
        <div className="flex items-center gap-2 text-sm text-slate-500 dark:text-slate-400">
          <Link href="/" className="hover:text-theme">
            Home
          </Link>
          <span>•</span>
          <span>Roadmap</span>
        </div>
      </div>

      <div className="space-y-8">
        {roadmapTopicsData.map((topic) => (
          <div key={topic.id} className="space-y-4">
            <div className="flex items-center gap-4">
              <div className="relative">
                <CircularProgress value={topic.progress} size={80} strokeWidth={8} color="#22c55e" />
                <div className="absolute inset-0 flex items-center justify-center">
                  <span className="text-lg font-bold dark:text-white">{topic.progress}%</span>
                </div>
              </div>
              <div>
                <div className="flex items-center gap-2">
                  <h2 className="text-xl font-bold dark:text-white">{topic.name}</h2>
                  {topic.recommended && (
                    <span className="text-xs text-slate-500 dark:text-slate-400">(Recommended)</span>
                  )}
                </div>
                <p className="text-sm text-slate-600 dark:text-slate-300">{topic.description}</p>
              </div>
            </div>

            {/* Resources Section */}
            <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
              <div
                className="p-4 flex justify-between items-center cursor-pointer"
                onClick={() => toggleSection(topic.id, "resources")}
              >
                <h3 className="font-medium dark:text-white">Resources ({topic.resources.length})</h3>
                {expandedSections[topic.id]?.resources ? (
                  <ChevronUp className="h-5 w-5 text-slate-400" />
                ) : (
                  <ChevronDown className="h-5 w-5 text-slate-400" />
                )}
              </div>
              {expandedSections[topic.id]?.resources && (
                <div className="px-4 pb-4">
                  <div className="space-y-3">
                    {topic.resources.map((resource) => (
                      <div key={resource.id} className="flex items-center gap-2">
                        <ExternalLink className="h-4 w-4 text-slate-400" />
                        <a
                          href={resource.url}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="text-blue-500 hover:text-blue-700 dark:text-blue-400 dark:hover:text-blue-300"
                        >
                          {resource.name}
                        </a>
                        <span className="text-xs text-slate-500 dark:text-slate-400 truncate flex-1">
                          {resource.url}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              )}
            </div>

            {/* Problems Section */}
            <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
              <div
                className="p-4 flex justify-between items-center cursor-pointer"
                onClick={() => toggleSection(topic.id, "problems")}
              >
                <h3 className="font-medium dark:text-white">Problems ({topic.problems.length}/17)</h3>
                {expandedSections[topic.id]?.problems ? (
                  <ChevronUp className="h-5 w-5 text-slate-400" />
                ) : (
                  <ChevronDown className="h-5 w-5 text-slate-400" />
                )}
              </div>
              {expandedSections[topic.id]?.problems && (
                <div className="px-4 pb-4 overflow-x-auto">
                  <div className="flex justify-between items-center mb-4">
                    <div className="flex items-center gap-2">
                      <button className="text-sm px-3 py-1 border rounded-md dark:border-slate-700 dark:text-white">
                        Columns
                      </button>
                      <button className="text-sm px-3 py-1 border rounded-md dark:border-slate-700 dark:text-white">
                        Filters
                      </button>
                      <button className="text-sm px-3 py-1 border rounded-md dark:border-slate-700 dark:text-white">
                        Export
                      </button>
                    </div>
                  </div>
                  <DataTable columns={problemsColumns} data={topic.problems} />
                </div>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
