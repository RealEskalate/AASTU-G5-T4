"use client"

import Image from "next/image"
import { ArrowUp, ArrowDown, ExternalLink, BarChart2 } from "lucide-react"
import MainLayout from "@/components/layout/main-layout"

export default function ContestsPage() {
  return (
    <MainLayout>
      <div className="p-6">
        <div className="mb-6">
          <h1 className="text-2xl font-semibold">Contests</h1>
          <div className="text-sm text-gray-500 mt-1">Ratings & contests</div>
        </div>

        <div className="grid grid-cols-2 gap-6">
          {/* Ratings Section */}
          <div className="bg-white rounded-lg shadow-sm border p-4">
            <div className="flex justify-between items-center mb-4">
              <h2 className="text-lg font-medium">Ratings</h2>
              <button className="flex items-center gap-1 text-blue-600 text-sm">
                <BarChart2 size={16} />
                <span>Visual</span>
              </button>
            </div>

            <div className="text-sm text-gray-500 mb-4">There are 317 users with ratings</div>

            <div className="space-y-4">
              {/* User Rating Item */}
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="text-gray-400 w-5">1</div>
                  <div className="w-8 h-8 rounded-full bg-gray-300 overflow-hidden">
                    <Image
                      src="/placeholder.svg?height=32&width=32"
                      alt="User"
                      width={32}
                      height={32}
                      className="object-cover"
                    />
                  </div>
                  <div>
                    <div className="font-medium">Kenenisa Alemayehu</div>
                    <div className="flex items-center text-xs text-gray-500">
                      <span className="bg-blue-100 text-blue-600 px-1 rounded mr-1">G47</span>
                      <span>Student</span>
                    </div>
                  </div>
                </div>
                <div className="font-semibold">2256</div>
              </div>

              {/* User Rating Item */}
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="text-gray-400 w-5">2</div>
                  <div className="w-8 h-8 rounded-full bg-gray-300 overflow-hidden">
                    <Image
                      src="/placeholder.svg?height=32&width=32"
                      alt="User"
                      width={32}
                      height={32}
                      className="object-cover"
                    />
                  </div>
                  <div>
                    <div className="font-medium">Abel Gashaw Ayalew</div>
                    <div className="flex items-center text-xs text-gray-500">
                      <span className="bg-yellow-100 text-yellow-600 px-1 rounded mr-1">G47</span>
                      <span>Student</span>
                    </div>
                  </div>
                </div>
                <div className="font-semibold">2168</div>
              </div>

              {/* User Rating Item */}
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-3">
                  <div className="text-gray-400 w-5">3</div>
                  <div className="w-8 h-8 rounded-full bg-gray-300 overflow-hidden">
                    <Image
                      src="/placeholder.svg?height=32&width=32"
                      alt="User"
                      width={32}
                      height={32}
                      className="object-cover"
                    />
                  </div>
                  <div>
                    <div className="font-medium">Simon Gebrehiwot Weldearegay</div>
                    <div className="flex items-center text-xs text-gray-500">
                      <span className="bg-yellow-100 text-yellow-600 px-1 rounded mr-1">G47</span>
                      <span>Student</span>
                    </div>
                  </div>
                </div>
                <div className="font-semibold">1902</div>
              </div>
            </div>
          </div>

          {/* Contests Section */}
          <div className="space-y-6">
            {/* Contest Item */}
            <div className="bg-white rounded-lg shadow-sm border p-4">
              <div className="flex justify-between items-center mb-2">
                <h3 className="text-lg font-medium">34. A2SV contest#35</h3>
                <div className="flex items-center gap-2">
                  <button className="text-gray-400">
                    <ArrowUp size={16} />
                  </button>
                  <span>0</span>
                  <button className="text-gray-400">
                    <ArrowDown size={16} />
                  </button>
                  <button className="text-gray-400">
                    <ExternalLink size={16} />
                  </button>
                </div>
              </div>

              <div className="text-sm text-gray-500 mb-2">5 problems • 1m ago</div>

              <div className="text-sm font-medium text-green-600">
                1st place, <span className="text-green-600">+63 gain</span>
              </div>
            </div>

            {/* Contest Item */}
            <div className="bg-white rounded-lg shadow-sm border p-4">
              <div className="flex justify-between items-center mb-2">
                <h3 className="text-lg font-medium">33. A2SV contest#34</h3>
                <div className="flex items-center gap-2">
                  <button className="text-gray-400">
                    <ArrowUp size={16} />
                  </button>
                  <span>0</span>
                  <button className="text-gray-400">
                    <ArrowDown size={16} />
                  </button>
                  <button className="text-gray-400">
                    <ExternalLink size={16} />
                  </button>
                </div>
              </div>

              <div className="text-sm text-gray-500 mb-2">6 problems • 1m ago</div>

              <div className="text-sm font-medium text-gray-600">You didn't participate in this contest</div>
            </div>

            {/* Contest Item with Results */}
            <div className="bg-white rounded-lg shadow-sm border">
              <div className="p-4 border-b">
                <div className="flex justify-between items-center mb-2">
                  <h3 className="text-lg font-medium">32. A2SV contest#33</h3>
                  <div className="flex items-center gap-2">
                    <button className="text-gray-400">
                      <ArrowUp size={16} />
                    </button>
                    <span>0</span>
                    <button className="text-gray-400">
                      <ArrowDown size={16} />
                    </button>
                    <button className="text-gray-400">
                      <ExternalLink size={16} />
                    </button>
                  </div>
                </div>

                <div className="text-sm text-gray-500 mb-2">5 problems • 1m ago</div>

                <div className="text-sm font-medium text-red-600">
                  2nd place, <span className="text-red-600">-19 gain</span>
                </div>
              </div>

              <div className="overflow-x-auto">
                <table className="w-full">
                  <thead>
                    <tr className="text-left text-sm text-gray-500 border-b">
                      <th className="px-4 py-3 font-medium">Rank</th>
                      <th className="px-4 py-3 font-medium">Contestant</th>
                      <th className="px-4 py-3 font-medium text-right">Solved</th>
                      <th className="px-4 py-3 font-medium text-right">Penalty</th>
                      <th className="px-4 py-3 font-medium text-right">Gain</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr className="border-b">
                      <td className="px-4 py-3">
                        <div className="flex items-center">
                          <span className="text-gray-400 mr-2">1st</span>
                        </div>
                      </td>
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
                          <span>Abel Ayalew</span>
                        </div>
                      </td>
                      <td className="px-4 py-3 text-right">5</td>
                      <td className="px-4 py-3 text-right">254</td>
                      <td className="px-4 py-3 text-right text-green-600">+132</td>
                    </tr>
                    <tr className="border-b bg-blue-50">
                      <td className="px-4 py-3">
                        <div className="flex items-center">
                          <span className="text-gray-400 mr-2">2nd</span>
                        </div>
                      </td>
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
                          <span>Kenenisa Alemayehu</span>
                        </div>
                      </td>
                      <td className="px-4 py-3 text-right">5</td>
                      <td className="px-4 py-3 text-right">305</td>
                      <td className="px-4 py-3 text-right text-red-600">-19</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </MainLayout>
  )
}

