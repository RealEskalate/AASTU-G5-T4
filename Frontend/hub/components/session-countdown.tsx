"use client"

import { useState, useEffect } from "react"
import { ExternalLink } from "lucide-react"
import { Button } from "@/components/ui/button"

interface SessionCountdownProps {
  title: string
  subtitle?: string
  endTime?: Date
  link?: string
}

export function SessionCountdown({ title, subtitle = "Event Coming up", endTime, link }: SessionCountdownProps) {
  const [timeLeft, setTimeLeft] = useState({
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0,
  })

  useEffect(() => {
    // If no end time is provided, use a default time 3 hours from now
    const targetTime = endTime || new Date(Date.now() + 3 * 60 * 60 * 1000)

    const calculateTimeLeft = () => {
      const difference = targetTime.getTime() - Date.now()

      if (difference <= 0) {
        return {
          days: 0,
          hours: 0,
          minutes: 0,
          seconds: 0,
        }
      }

      return {
        days: Math.floor(difference / (1000 * 60 * 60 * 24)),
        hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
        minutes: Math.floor((difference / (1000 * 60)) % 60),
        seconds: Math.floor((difference / 1000) % 60),
      }
    }

    setTimeLeft(calculateTimeLeft())

    const timer = setInterval(() => {
      setTimeLeft(calculateTimeLeft())
    }, 1000)

    return () => clearInterval(timer)
  }, [endTime])

  return (
    <div className="bg-white p-4 rounded-lg shadow-sm dark:bg-slate-800 dark:border dark:border-slate-700">
      <div className="mb-4">
        <h3 className="text-lg font-semibold dark:text-white">{title}</h3>
        <p className="text-sm text-slate-500 dark:text-slate-400">{subtitle}</p>
      </div>

      <div className="flex justify-center gap-4 mb-4">
        <div className="text-center">
          <div className="text-2xl font-bold dark:text-white">{timeLeft.days.toString().padStart(2, "0")}</div>
          <div className="text-xs text-slate-500 dark:text-slate-400">Days</div>
        </div>
        <div className="text-center">
          <div className="text-2xl font-bold dark:text-white">:</div>
          <div className="text-xs invisible">.</div>
        </div>
        <div className="text-center">
          <div className="text-2xl font-bold dark:text-white">{timeLeft.hours.toString().padStart(2, "0")}</div>
          <div className="text-xs text-slate-500 dark:text-slate-400">Hours</div>
        </div>
        <div className="text-center">
          <div className="text-2xl font-bold dark:text-white">:</div>
          <div className="text-xs invisible">.</div>
        </div>
        <div className="text-center">
          <div className="text-2xl font-bold dark:text-white">{timeLeft.minutes.toString().padStart(2, "0")}</div>
          <div className="text-xs text-slate-500 dark:text-slate-400">Minutes</div>
        </div>
        <div className="text-center">
          <div className="text-2xl font-bold dark:text-white">:</div>
          <div className="text-xs invisible">.</div>
        </div>
        <div className="text-center">
          <div className="text-2xl font-bold dark:text-white">{timeLeft.seconds.toString().padStart(2, "0")}</div>
          <div className="text-xs text-slate-500 dark:text-slate-400">Seconds</div>
        </div>
      </div>

      {link && (
        <div className="flex justify-end">
          <Button variant="ghost" size="sm" className="text-theme hover:text-theme-dark p-0">
            LINK <ExternalLink className="ml-1 h-4 w-4" />
          </Button>
        </div>
      )}
    </div>
  )
}
