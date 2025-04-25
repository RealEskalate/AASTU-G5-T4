"use client";

import { ArrowBigDown, ArrowBigUp, ArrowBigUpDash, ArrowBigUpIcon, ArrowUp, MessageCircle } from "lucide-react";
import MainLayout from "@/components/layout/main-layout";
import { CircularProgress } from "@/components/circular-progress";
import { useEffect, useState } from "react";
import { motion } from "framer-motion";

export default function TracksPage() {
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    setMounted(true); // Set mounted to true only on the client-side
  }, []);

  if (!mounted) {
    return null; // Return nothing during SSR
  }

  return (
    <div className="p-6">
      <motion.div
        initial={{ opacity: 0 }}
        animate={{ opacity: 1 }}
        transition={{ duration: 0.5 }}
        className="mb-6"
      >
        <h1 className="text-2xl font-semibold">Tracks</h1>
        <div className="text-sm text-gray-500 mt-1">All</div>
      </motion.div>

      <div className="grid grid-cols-3 gap-6">
        {/* Progress Track */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
          className="bg-white rounded-lg border shadow-xs p-4"
        >
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-lg font-medium">Progress</h2>
            <div className="flex items-center gap-4">
                <button className="flex items-center gap-1 text-theme hover:text-theme-dark">
                  <ArrowBigUp fill="currentColor" />
                  <span>3</span>
                  <ArrowBigDown fill="currentColor" />
                </button>
              <button className="text-gray-400">
                <MessageCircle size={18} />
              </button>
            </div>
          </div>

          <div className="flex justify-center mb-6">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5 }}
              className="flex justify-center"
            >
              <CircularProgress

                value={(147 / 271) * 100} // Calculate percentage
                size={100} // Replace with an appropriate numeric value for "lg"
              />
            </motion.div>
          </div>

          <div className="space-y-4">
            <div className="flex items-center gap-3">
              <div className="w-3 h-3 rounded-sm bg-theme hover:bg-theme-dark text-white"></div>
              <span>Solved</span>
              <span className="ml-auto">147 Problems</span>
            </div>
            <div className="flex items-center gap-3">
              <div className="w-3 h-3 rounded-sm bg-gray-300"></div>
              <span>Available</span>
              <span className="ml-auto">271 Problems</span>
            </div>
            <button className="w-full py-2 text-center text-blue-600 border border-gray-200 rounded-md mt-2">
              Problems
            </button>
            <button className="w-full py-2 text-center rounded-md bg-theme hover:bg-theme-dark text-white">
              Exercise
            </button>
          </div>
        </motion.div>

        {/* Test Onboarding Progress */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.5 }}
          className="bg-white rounded-lg shadow-sm border p-4"
        >
          <div className="flex justify-between items-center mb-6">
            <h2 className="text-lg font-medium">Test Onboarding Progress</h2>
            <div className="flex items-center gap-4">
              <button className="flex items-center gap-1 text-theme hover:text-theme-dark">
                <ArrowBigUp fill="currentcolor" />
                <span>0</span>
                <ArrowBigDown fill="currentcolor" />
              </button>
              <button className="text-gray-400">
                <MessageCircle size={18} />
              </button>
            </div>
          </div>

          <div className="flex justify-center mb-6">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5 }}
              className="flex justify-center"
            >
              <CircularProgress
                value={(0 / 1) * 100} // Calculate percentage
                color="gray"
                size={100} // Replace with an appropriate numeric value
              />
            </motion.div>
          </div>

          <div className="space-y-4">
            <div className="flex items-center gap-3">
              <div className="w-3 h-3 rounded-sm bg-theme hover:bg-theme-dark text-white"></div>
              <span>Solved</span>
              <span className="ml-auto">0 Problems</span>
            </div>
            <div className="flex items-center gap-3">
              <div className="w-3 h-3 rounded-sm bg-gray-300"></div>
              <span>Available</span>
              <span className="ml-auto">1 Problems</span>
            </div>
            <button className="w-full py-2 text-center text-blue-600 border border-gray-200 rounded-md mt-2">
              Problems
            </button>
            <button className="w-full py-2 text-center bg-theme hover:bg-theme-dark text-white">
              Exercise
            </button>
          </div>
        </motion.div>
      </div>

      <div className="grid grid-cols-2 gap-6 mt-6">
        {/* Solved Progress */}
        <motion.div
          initial={{ opacity: 0, x: -20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5 }}
          className="bg-white rounded-lg shadow-sm border p-4"
        >
          <div className="flex items-center gap-4 mb-4">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5 }}
              className="flex justify-center"
            >
              <CircularProgress
                value={(35 / 100) * 100} // Calculate percentage
                color="blue"
                size={60} // Replace with an appropriate numeric value
              />
            </motion.div>
            <div>
              <div className="text-xl font-semibold">147</div>
              <div className="text-gray-500">Solved</div>
            </div>
          </div>
        </motion.div>

        {/* Available Progress */}
        <motion.div
          initial={{ opacity: 0, x: 20 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 0.5 }}
          className="bg-white rounded-lg shadow-sm border p-4"
        >
          <div className="flex items-center gap-4 mb-4">
            <motion.div
              initial={{ opacity: 0 }}
              animate={{ opacity: 1 }}
              transition={{ duration: 0.5 }}
              className="flex justify-center"
            >
              <CircularProgress
                value={(65 / 100) * 100} // Calculate percentage
                color="yellow"
                size={60} // Replace with an appropriate numeric value
              />
            </motion.div>
            <div>
              <div className="text-xl font-semibold">272</div>
              <div className="text-gray-500">Available</div>
            </div>
          </div>
        </motion.div>
      </div>
    </div>
  );
}