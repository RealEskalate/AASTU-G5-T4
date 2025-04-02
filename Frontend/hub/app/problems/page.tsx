"use client"

import { Columns, Filter, Download, ArrowUp, ArrowDown, ExternalLink, Check } from "lucide-react"
import MainLayout from "@/components/layout/main-layout"
import DifficultyBadge from "@/components/difficulty-badge"

export default function ProblemsPage() {
  return (
    <MainLayout>
      <div className="p-6">
        <div className="mb-6">
          <h1 className="text-2xl font-semibold">Problems</h1>
          <div className="text-sm text-gray-500 mt-1">All</div>
        </div>

        <div className="bg-gray-50 p-3 rounded-md flex gap-4 mb-6">
          <button className="flex items-center gap-2 px-3 py-2 text-sm rounded bg-white shadow-sm border">
            <Columns size={16} />
            <span>Columns</span>
          </button>
          <button className="flex items-center gap-2 px-3 py-2 text-sm rounded hover:bg-white hover:shadow-sm hover:border">
            <Filter size={16} />
            <span>Filters</span>
          </button>
          <button className="flex items-center gap-2 px-3 py-2 text-sm rounded hover:bg-white hover:shadow-sm hover:border">
            <Download size={16} />
            <span>Export</span>
          </button>
        </div>

        <div className="bg-white rounded-lg shadow-sm border overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="text-left text-sm text-gray-500 border-b">
                  <th className="px-4 py-3 font-medium">Diff.</th>
                  <th className="px-4 py-3 font-medium">Name</th>
                  <th className="px-4 py-3 font-medium">Tag</th>
                  <th className="px-4 py-3 font-medium">Solved</th>
                  <th className="px-4 py-3 font-medium">Added</th>
                  <th className="px-4 py-3 font-medium">
                    <div className="flex items-center gap-1">
                      Vote
                      <div className="flex flex-col">
                        <ArrowUp size={12} />
                        <ArrowDown size={12} />
                      </div>
                    </div>
                  </th>
                  <th className="px-4 py-3 font-medium">Link</th>
                </tr>
              </thead>
              <tbody>
                <tr className="border-b hover:bg-gray-50">
                  <td className="px-4 py-3">
                    <DifficultyBadge difficulty="Medium" />
                  </td>
                  <td className="px-4 py-3">Pseudo-Palindromic Paths in a Binary Tree</td>
                  <td className="px-4 py-3">Bit Manip...</td>
                  <td className="px-4 py-3">-</td>
                  <td className="px-4 py-3">1d</td>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-1">
                      <span>0</span>
                      <div className="flex flex-col">
                        <ArrowUp size={12} className="text-gray-400" />
                        <ArrowDown size={12} className="text-gray-400" />
                      </div>
                    </div>
                  </td>
                  <td className="px-4 py-3">
                    <button className="text-gray-400 hover:text-gray-600">
                      <ExternalLink size={16} />
                    </button>
                  </td>
                </tr>
                <tr className="border-b hover:bg-gray-50">
                  <td className="px-4 py-3">
                    <DifficultyBadge difficulty="Easy" />
                  </td>
                  <td className="px-4 py-3">Two Sum</td>
                  <td className="px-4 py-3">Array, Has...</td>
                  <td className="px-4 py-3">-</td>
                  <td className="px-4 py-3">1m</td>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-1">
                      <span>1</span>
                      <div className="flex flex-col">
                        <ArrowUp size={12} className="text-blue-500" />
                        <ArrowDown size={12} className="text-gray-400" />
                      </div>
                    </div>
                  </td>
                  <td className="px-4 py-3">
                    <button className="text-gray-400 hover:text-gray-600">
                      <ExternalLink size={16} />
                    </button>
                  </td>
                </tr>
                <tr className="border-b hover:bg-gray-50">
                  <td className="px-4 py-3">
                    <DifficultyBadge difficulty="Medium" />
                  </td>
                  <td className="px-4 py-3">Add Binary</td>
                  <td className="px-4 py-3">Bits</td>
                  <td className="px-4 py-3">
                    <div className="text-blue-500">
                      <Check size={16} />
                    </div>
                  </td>
                  <td className="px-4 py-3">1m</td>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-1">
                      <span>2</span>
                      <div className="flex flex-col">
                        <ArrowUp size={12} className="text-blue-500" />
                        <ArrowDown size={12} className="text-gray-400" />
                      </div>
                    </div>
                  </td>
                  <td className="px-4 py-3">
                    <button className="text-gray-400 hover:text-gray-600">
                      <ExternalLink size={16} />
                    </button>
                  </td>
                </tr>
                <tr className="border-b hover:bg-gray-50">
                  <td className="px-4 py-3">
                    <DifficultyBadge difficulty="Easy" />
                  </td>
                  <td className="px-4 py-3">Sum of Two Integers</td>
                  <td className="px-4 py-3">Bits</td>
                  <td className="px-4 py-3">
                    <div className="text-blue-500">
                      <Check size={16} />
                    </div>
                  </td>
                  <td className="px-4 py-3">1m</td>
                  <td className="px-4 py-3">
                    <div className="flex items-center gap-1">
                      <span>0</span>
                      <div className="flex flex-col">
                        <ArrowUp size={12} className="text-gray-400" />
                        <ArrowDown size={12} className="text-gray-400" />
                      </div>
                    </div>
                  </td>
                  <td className="px-4 py-3">
                    <button className="text-gray-400 hover:text-gray-600">
                      <ExternalLink size={16} />
                    </button>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </MainLayout>
  )
}

