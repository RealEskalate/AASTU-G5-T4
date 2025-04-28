"use client";

import {
  LucideColumns3,
  Download,
  ArrowUp,
  ArrowDown,
  ExternalLink,
  Check,
  ListFilterIcon,
  ArrowBigUp,
  ArrowBigDown,
} from "lucide-react";
import { DifficultyBadge } from "@/components/difficulty-badge";

export default function ProblemsPage() {
  return (
    <div className="p-6 text-sm">
      <div className="mb-6">
        <h1 className="text-2xl font-semibold">Problems</h1>
        <div className="text-sm text-gray-500 mt-1">All</div>
      </div>

      <div className=" p-3 flex bg-white mb-6 font-bold">
        <button className="flex items-center gap-2 px-5 py-2 text-sm rounded">
          <LucideColumns3 size={16} />
          <span>Columns</span>
        </button>
        <button className="flex items-center gap-2 px-5 py-2 text-sm rounded">
          <ListFilterIcon size={16} />
          <span>Filters</span>
        </button>
        <button className="flex items-center gap-2 px-5 py-2 text-sm rounded">
          <Download size={16} />
          <span>Export</span>
        </button>
      </div>

      <div className="bg-white overflow-hidden font-bold">
        <div className="overflow-x-auto">
          <table className="w-full border-collapse text-xs">
            <thead>
              <tr className="text-left text-sm text-gray-500 border-b font-bold">
                <th className="pl-5 py-3 font-sm">Diff...</th>
                <th className="px-1 py-3 font-sm">Name</th>
                <th className="px-1 py-3 font-sm">Tag</th>
                <th className="px-1 py-3 font-sm">Solved</th>
                <th className="px-1 py-3 font-sm">Added</th>
                <th className="px-1 py-3 font-sm">
                  <div className="flex items-center gap-1">
                    Vote
                    <div className="flex flex-col">
                      <ArrowBigUp size={12} />
                      <ArrowBigDown size={12} />
                    </div>
                  </div>
                </th>
                <th className="px-2 py-3 font-medium">Link</th>
              </tr>
            </thead>
            <tbody>
              <tr className="border-b hover:bg-gray-50">
                <td className="px-2 py-3">
                  <DifficultyBadge level="medium" />
                </td>
                <td className="px-2 py-3">
                  Pseudo-Palindromic Paths in a Binary Tree
                </td>
                <td className="px-2 py-3">Bit Manip...</td>
                <td className="px-2 py-3">-</td>
                <td className="px-2 py-3">1d</td>
                <td className="px-2 py-3">
                  <div className="flex items-center gap-1">
                    <span>0</span>
                    <div className="flex flex-col">
                      <ArrowBigUp size={12} className="text-gray-400" />
                      <ArrowBigDown size={12} className="text-gray-400" />
                    </div>
                  </div>
                </td>
                <td className="px-2 py-3">
                  <button className="text-gray-400 hover:text-gray-600">
                    <ExternalLink size={16} />
                  </button>
                </td>
              </tr>
              <tr className="border-b hover:bg-gray-50">
                <td className="px-2 py-3">
                  <DifficultyBadge level="easy" />
                </td>
                <td className="px-2 py-3">Two Sum</td>
                <td className="px-2 py-3">Array, Has...</td>
                <td className="px-2 py-3">-</td>
                <td className="px-2 py-3">1m</td>
                <td className="px-2 py-3">
                  <div className="flex items-center gap-1">
                    <span>1</span>
                    <div className="flex flex-col">
                      <ArrowBigUp size={12} className="text-blue-500" />
                      <ArrowBigDown size={12} className="text-gray-400" />
                    </div>
                  </div>
                </td>
                <td className="px-2 py-3">
                  <button className="text-gray-400 hover:text-gray-600">
                    <ExternalLink size={16} />
                  </button>
                </td>
              </tr>
              <tr className="border-b hover:bg-gray-50">
                <td className="px-2 py-3">
                  <DifficultyBadge level="medium" />
                </td>
                <td className="px-2 py-3">Add Binary</td>
                <td className="px-2 py-3">Bits</td>
                <td className="px-2 py-3">
                  <div className="text-blue-500">
                    <Check size={16} />
                  </div>
                </td>
                <td className="px-2 py-3">1m</td>
                <td className="px-2 py-3">
                  <div className="flex items-center gap-1">
                    <span>2</span>
                    <div className="flex flex-col">
                      <ArrowBigUp size={12} className="text-blue-500" />
                      <ArrowBigDown size={12} className="text-gray-400" />
                    </div>
                  </div>
                </td>
                <td className="px-2 py-3">
                  <button className="text-gray-400 hover:text-gray-600">
                    <ExternalLink size={16} />
                  </button>
                </td>
              </tr>
              <tr className="border-b hover:bg-gray-50">
                <td className="px-2 py-3">
                  <DifficultyBadge level="easy" />
                </td>
                <td className="px-2 py-3">Sum of Two Integers</td>
                <td className="px-2 py-3">Bits</td>
                <td className="px-2 py-3">
                  <div className="text-blue-500">
                    <Check size={16} />
                  </div>
                </td>
                <td className="px-2 py-3">1m</td>
                <td className="px-2 py-3">
                  <div className="flex items-center gap-1">
                    <span>0</span>
                    <div className="flex flex-col">
                      <ArrowBigUp size={12} className="text-gray-400" />
                      <ArrowBigDown size={12} className="text-gray-400" />
                    </div>
                  </div>
                </td>
                <td className="px-2 py-3">
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
  );
}
