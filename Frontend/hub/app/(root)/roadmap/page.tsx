"use client";

import { useState } from "react";
import Link from "next/link";
import { ChevronDown, ChevronUp, ExternalLink } from "lucide-react";
import { CircularProgress } from "@/components/circular-progress";
import { useGetProblemsByTagsQuery } from "@/lib/redux/api/problemApiSlice";
import { useTheme } from "@/components/theme/theme-provider";

export default function RoadmapPage() {
  const { colorPreset } = useTheme();

  const getColor = () => {
    switch (colorPreset) {
      case "purple":
        return "#a855f7";
      case "blue":
        return "#3b82f6";
      case "orange":
        return "#f97316";
      case "red":
        return "#ef4444";
      case "indigo":
        return "#6366f1";
      default:
        return "#22c55e";
    }
  };

  const [expandedSections, setExpandedSections] = useState<Record<string, { resources: boolean; problems: boolean }>>(
    {}
  );

  const { data: problemsByTags, isLoading } = useGetProblemsByTagsQuery();

  const toggleSection = (topicId: string, section: "resources" | "problems") => {
    setExpandedSections((prev) => {
      const topicState = prev[topicId] || { resources: false, problems: false };
      return {
        ...prev,
        [topicId]: {
          ...topicState,
          [section]: !topicState[section],
        },
      };
    });
  };

  const roadmapTopicsData = [
    {
      id: "math",
      name: "Math",
      description:
        "Embark on a journey of mathematical wonders, where numbers dance and equations weave the fabric of the universe.",
      progress: 12,
      recommended: true,
    },
    {
      id: "array",
      name: "Array",
      description: "Master the fundamental data structure that powers countless algorithms and solutions.",
      progress: 62,
      recommended: false,
    },
    {
      id: "string",
      name: "String",
      description: "Explore the versatile world of text manipulation and pattern matching algorithms.",
      progress: 32,
      recommended: false,
    },
    {
      id: "sorting",
      name: "Sorting",
      description: "Learn the art of arranging elements in a specific order, a fundamental skill in programming.",
      progress: 0,
      recommended: false,
    },
  ];

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
        {roadmapTopicsData.map((topic) => {
          const problemCount = problemsByTags?.[topic.name]?.length || 0;

          return (
            <div key={topic.id} className="space-y-4">
              <div className="flex items-center gap-4">
                <div className="relative">
                  <CircularProgress value={topic.progress} size={50} strokeWidth={6} color={getColor()} />
                </div>
                <div>
                  <div className="flex items-center gap-2">
                    <h2 className="text-lg font-bold dark:text-white">{topic.name}</h2>
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
                  <h3 className="font-medium dark:text-white">Resources</h3>
                  {expandedSections[topic.id]?.resources ? (
                    <ChevronUp className="h-5 w-5 text-slate-400" />
                  ) : (
                    <ChevronDown className="h-5 w-5 text-slate-400" />
                  )}
                </div>
                {expandedSections[topic.id]?.resources && (
                  <div className="px-4 pb-4">
                    <p className="text-sm text-slate-500 dark:text-slate-400">No resources available.</p>
                  </div>
                )}
              </div>

              {/* Problems Section */}
              <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
                <div
                  className="p-4 flex justify-between items-center cursor-pointer"
                  onClick={() => toggleSection(topic.id, "problems")}
                >
                  <h3 className="font-medium dark:text-white">
                    Problems ({problemCount})
                  </h3>
                  {expandedSections[topic.id]?.problems ? (
                    <ChevronUp className="h-5 w-5 text-slate-400" />
                  ) : (
                    <ChevronDown className="h-5 w-5 text-slate-400" />
                  )}
                </div>
                {expandedSections[topic.id]?.problems && (
                  <div className="px-4 pb-4">
                    {isLoading ? (
                      <p className="text-sm text-slate-500 dark:text-slate-400">Loading problems...</p>
                    ) : problemCount > 0 ? (
                      <ul className="space-y-2">
                        {problemsByTags?.[topic.name]?.map((problem) => (
                          <li key={problem.ID} className="text-sm text-slate-600 dark:text-slate-300">
                            {problem.Name}
                          </li>
                        ))}
                      </ul>
                    ) : (
                      <p className="text-sm text-slate-500 dark:text-slate-400">No problems available.</p>
                    )}
                  </div>
                )}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
