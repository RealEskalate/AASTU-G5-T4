"use client"

import type React from "react"

import { useState } from "react"
import Link from "next/link"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { Edit, Code } from "lucide-react"

export default function ProblemSubmissionPage() {
  const [activeTab, setActiveTab] = useState<"edit" | "preview">("edit")
  const [code, setCode] = useState("")
  const [timeSpent, setTimeSpent] = useState("")
  const [tries, setTries] = useState("")
  const [language, setLanguage] = useState("")

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Handle submission logic here
    console.log({ code, timeSpent, tries, language })
  }

  return (
    <div className="p-4 md:p-6 max-w-4xl mx-auto">
      <div className="mb-6">
        <h1 className="text-2xl font-bold dark:text-white">Add Submission</h1>
        <div className="text-sm text-slate-500 dark:text-slate-400 flex items-center gap-2">
          <Link href="/problems" className="hover:text-theme">
            Problems
          </Link>
          <span>•</span>
          <span>Find Median from Data Stream</span>
        </div>
      </div>

      <form onSubmit={handleSubmit} className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label htmlFor="timeSpent" className="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-1">
              Time Spent
            </label>
            <Input
              id="timeSpent"
              type="text"
              placeholder="Time Spent"
              value={timeSpent}
              onChange={(e) => setTimeSpent(e.target.value)}
              className="w-full dark:bg-slate-800 dark:border-slate-700"
            />
          </div>
          <div>
            <label htmlFor="tries" className="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-1">
              Tries
            </label>
            <Input
              id="tries"
              type="text"
              placeholder="Tries"
              value={tries}
              onChange={(e) => setTries(e.target.value)}
              className="w-full dark:bg-slate-800 dark:border-slate-700"
            />
          </div>
        </div>

        <div>
          <label htmlFor="language" className="block text-sm font-medium text-slate-700 dark:text-slate-300 mb-1">
            Language
          </label>
          <select
            id="language"
            value={language}
            onChange={(e) => setLanguage(e.target.value)}
            className="w-full h-10 px-3 py-2 rounded-md border border-slate-200 focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent dark:bg-slate-800 dark:border-slate-700 dark:text-white"
          >
            <option value="" disabled>
              Select Language
            </option>
            <option value="python">Python</option>
            <option value="javascript">JavaScript</option>
            <option value="java">Java</option>
            <option value="cpp">C++</option>
            <option value="go">Go</option>
          </select>
        </div>

        <div>
          <Tabs
            defaultValue="edit"
            className="w-full"
            onValueChange={(value) => setActiveTab(value as "edit" | "preview")}
          >
            <TabsList className="border-b dark:border-slate-700 bg-transparent mb-4 w-full justify-start">
              <TabsTrigger
                value="edit"
                className={`${
                  activeTab === "edit"
                    ? "border-b-2 border-green-500 text-slate-900 dark:text-white"
                    : "text-slate-500 dark:text-slate-400"
                } rounded-none px-4 py-2 font-medium`}
              >
                <Edit className="h-4 w-4 mr-2" />
                Edit
              </TabsTrigger>
              <TabsTrigger
                value="preview"
                className={`${
                  activeTab === "preview"
                    ? "border-b-2 border-green-500 text-slate-900 dark:text-white"
                    : "text-slate-500 dark:text-slate-400"
                } rounded-none px-4 py-2 font-medium`}
              >
                <Code className="h-4 w-4 mr-2" />
                Preview
              </TabsTrigger>
            </TabsList>

            <TabsContent value="edit" className="mt-0">
              <div className="border rounded-md dark:border-slate-700 overflow-hidden">
                <textarea
                  id="code"
                  value={code}
                  onChange={(e) => setCode(e.target.value)}
                  placeholder="Code"
                  className="w-full h-64 p-4 resize-none focus:outline-none dark:bg-slate-800 dark:text-white"
                ></textarea>
              </div>
            </TabsContent>

            <TabsContent value="preview" className="mt-0">
              <div className="border rounded-md dark:border-slate-700 p-4 h-64 overflow-auto dark:bg-slate-800 dark:text-white">
                {code ? (
                  <pre className="whitespace-pre-wrap">{code}</pre>
                ) : (
                  <div className="text-slate-400 dark:text-slate-500">No code to preview</div>
                )}
              </div>
            </TabsContent>
          </Tabs>
        </div>

        <div className="flex justify-end">
          <Button type="submit" className="bg-green-500 hover:bg-green-600 text-white">
            Submit
          </Button>
        </div>
      </form>

      <div className="mt-8 text-xs text-slate-500 dark:text-slate-400 text-center">
        Created and maintained by Kenenisa Alemayehu.
      </div>
    </div>
  )
}
