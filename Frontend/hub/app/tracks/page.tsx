"use client"

import { ArrowUp, MessageCircle } from "lucide-react"
import MainLayout from "@/components/layout/main-layout"
import CircularProgress from "@/components/circular-progress"

export default function TracksPage() {
  return (
    <MainLayout>
      <div className="p-6">
        <div className="mb-6">
          <h1 className="text-2xl font-semibold">Tracks</h1>
          <div className="text-sm text-gray-500 mt-1">All</div>
        </div>

        <div className="grid grid-cols-2 gap-6">
          {/* Progress Track */}
          <div className="bg-white rounded-lg shadow-sm border p-4">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-lg font-medium">Progress</h2>
              <div className="flex items-center gap-4">
                <div className="flex items-center gap-1 text-green-600">
                  <ArrowUp size={16} />
                  <span>3</span>
                </div>
                <button className="text-gray-400">
                  <MessageCircle size={18} />
                </button>
              </div>
            </div>

            <div className="flex justify-center mb-6">
              <CircularProgress title="Problems" value={418} total={418} color="blue" size="lg" />
            </div>

            <div className="space-y-4">
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-blue-500"></div>
                <span>Solved</span>
                <span className="ml-auto">147 Problems</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-gray-300"></div>
                <span>Available</span>
                <span className="ml-auto">271 Problems</span>
              </div>
              <button className="w-full py-2 text-center text-blue-600 border border-gray-200 rounded-md mt-2">
                Problems
              </button>
            </div>
          </div>

          {/* Test Onboarding Progress */}
          <div className="bg-white rounded-lg shadow-sm border p-4">
            <div className="flex justify-between items-center mb-6">
              <h2 className="text-lg font-medium">Test Onboarding Progress</h2>
              <div className="flex items-center gap-4">
                <div className="flex items-center gap-1 text-gray-400">
                  <ArrowUp size={16} />
                  <span>0</span>
                </div>
                <button className="text-gray-400">
                  <MessageCircle size={18} />
                </button>
              </div>
            </div>

            <div className="flex justify-center mb-6">
              <CircularProgress title="Problems" value={1} total={1} color="gray" size="lg" />
            </div>

            <div className="space-y-4">
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-blue-500"></div>
                <span>Solved</span>
                <span className="ml-auto">0 Problems</span>
              </div>
              <div className="flex items-center gap-3">
                <div className="w-3 h-3 rounded-full bg-gray-300"></div>
                <span>Available</span>
                <span className="ml-auto">1 Problems</span>
              </div>
              <button className="w-full py-2 text-center text-blue-600 border border-gray-200 rounded-md mt-2">
                Problems
              </button>
            </div>
          </div>
        </div>

        <div className="grid grid-cols-2 gap-6 mt-6">
          {/* Solved Progress */}
          <div className="bg-white rounded-lg shadow-sm border p-4">
            <div className="flex items-center gap-4 mb-4">
              <CircularProgress title="35%" value={35} total={100} color="blue" size="sm" />
              <div>
                <div className="text-xl font-semibold">147</div>
                <div className="text-gray-500">Solved</div>
              </div>
            </div>
          </div>

          {/* Available Progress */}
          <div className="bg-white rounded-lg shadow-sm border p-4">
            <div className="flex items-center gap-4 mb-4">
              <CircularProgress title="65%" value={65} total={100} color="yellow" size="sm" />
              <div>
                <div className="text-xl font-semibold">272</div>
                <div className="text-gray-500">Available</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </MainLayout>
  )
}

