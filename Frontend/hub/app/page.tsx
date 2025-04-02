"use client"

import Image from "next/image"
import Link from "next/link"
import { BarChart2 } from "lucide-react"
import MainLayout from "@/components/layout/main-layout"
import SessionCountdown from "@/components/session-countdown"
import StatsCard from "@/components/stats-card"

export default function HomePage() {
  return (
    <MainLayout>
      <div className="p-6">
        <div className="grid grid-cols-3 gap-6">
          {/* Main Content - 2/3 width */}
          <div className="col-span-2 space-y-6">
            {/* Welcome Banner */}
            <div className="bg-blue-50 rounded-lg p-6 relative overflow-hidden">
              <div className="max-w-md relative z-10">
                <h2 className="text-2xl font-semibold text-gray-800 mb-1">Heaven is right where you are standing.</h2>
                <p className="text-gray-600 mb-4">— Morihei Ueshiba</p>
                <p className="mb-4">
                  Welcome back,
                  <br />
                  Kenenisa!
                </p>
                <Link
                  href="/problems"
                  className="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition inline-block"
                >
                  Problems
                </Link>
              </div>
              <div className="absolute right-6 bottom-0 opacity-90">
                <Image
                  src="/placeholder.svg?height=180&width=180"
                  alt="Dashboard illustration"
                  width={180}
                  height={180}
                />
              </div>
            </div>

            {/* Stats Cards */}
            <div className="grid grid-cols-3 gap-6">
              <StatsCard title="Solutions" value="5,247" percentage="2.6%" isPositive={true} />
              <StatsCard title="Time Spent" value="160,356" percentage="0.2%" isPositive={true} />
              <StatsCard title="Rating" value="1,399" percentage="0.1%" isPositive={true} />
            </div>

            {/* Groups */}
            <div className="space-y-3">
              <div className="flex justify-between items-center bg-white rounded-lg p-4 shadow-sm border">
                <div>A2SV Remote Group 47</div>
                <div className="text-gray-500">G47</div>
              </div>
              <div className="flex justify-between items-center bg-white rounded-lg p-4 shadow-sm border">
                <div>A2SV AASTU Group 46</div>
                <div className="text-gray-500">G46</div>
              </div>
            </div>

            {/* Latest Submissions */}
            <div className="bg-white rounded-lg shadow-sm border">
              <div className="p-4 border-b">
                <h3 className="font-semibold">Latest Submissions</h3>
              </div>
              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr className="text-left text-sm text-gray-500 border-b">
                      <th className="px-4 py-3 font-medium">Name</th>
                      <th className="px-4 py-3 font-medium text-right">Time spent</th>
                      <th className="px-4 py-3 font-medium">Language</th>
                      <th className="px-4 py-3 font-medium">Added</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr className="border-b">
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-3">
                          <div className="w-8 h-8 rounded-full bg-gray-300 overflow-hidden">
                            <Image
                              src="/placeholder.svg?height=32&width=32"
                              alt="User"
                              width={32}
                              height={32}
                              className="object-cover"
                            />
                          </div>
                          <span>Yidnekachew Tebeje</span>
                        </div>
                      </td>
                      <td className="px-4 py-3 text-right">2</td>
                      <td className="px-4 py-3">C++</td>
                      <td className="px-4 py-3">1m</td>
                    </tr>
                    <tr>
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-3">
                          <div className="w-8 h-8 rounded-full bg-blue-100 overflow-hidden flex items-center justify-center text-blue-600">
                            <span>K</span>
                          </div>
                          <span>Kibrom Hailu</span>
                        </div>
                      </td>
                      <td className="px-4 py-3 text-right">23</td>
                      <td className="px-4 py-3">Python</td>
                      <td className="px-4 py-3">1m</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          {/* Right Sidebar - 1/3 width */}
          <div className="space-y-6">
            <SessionCountdown />

            <div className="bg-white rounded-lg p-4 shadow-sm border flex items-center justify-between">
              <div className="flex items-center gap-2">
                <BarChart2 className="text-gray-400" size={20} />
                <span className="font-medium">Analytics</span>
              </div>
              <button className="text-blue-600">View</button>
            </div>
          </div>
        </div>
      </div>
    </MainLayout>
  )
}

