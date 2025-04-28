"use client"

import type React from "react"

import { useState, useEffect, useRef } from "react"
import { Eye, EyeOff } from "lucide-react"
import { getThemeColor } from "@/lib/utils"
import { Button } from "@/components/ui/button"

interface LoginDropdownProps {
  isOpen: boolean
  onClose: () => void
}

export function LoginDropdown({ isOpen, onClose }: LoginDropdownProps) {
  const [themeColor, setThemeColor] = useState("#10b981")
  const [email, setEmail] = useState("")
  const [password, setPassword] = useState("")
  const [rememberMe, setRememberMe] = useState(false)
  const [showPassword, setShowPassword] = useState(false)
  const dropdownRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    setThemeColor(getThemeColor())

    const handleClickOutside = (event: MouseEvent) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target as Node)) {
        onClose()
      }
    }

    if (isOpen) {
      document.addEventListener("mousedown", handleClickOutside)
    }

    return () => {
      document.removeEventListener("mousedown", handleClickOutside)
    }
  }, [isOpen, onClose])

  if (!isOpen) return null

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    // Handle login logic here
    console.log({ email, password, rememberMe })
  }

  return (
    <div
      ref={dropdownRef}
      className="absolute top-16 right-0 w-80 bg-white rounded-lg shadow-lg z-50 border border-gray-100"
    >
      <div className="p-6">
        <h2 className="text-xl font-bold mb-4">Sign in to A2SV Hub</h2>

        <form onSubmit={handleSubmit}>
          <div className="mb-4">
            <label htmlFor="email" className="block text-sm text-gray-500 mb-1">
              Email address
            </label>
            <input
              id="email"
              type="email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full p-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-2"
              style={{ focusRing: themeColor }}
              placeholder="natnael.worku@a2sv.org"
              required
            />
          </div>

          <div className="mb-4">
            <label htmlFor="password" className="block text-sm text-gray-500 mb-1">
              Password
            </label>
            <div className="relative">
              <input
                id="password"
                type={showPassword ? "text" : "password"}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full p-2 border border-gray-200 rounded-lg focus:outline-none focus:ring-2 pr-10"
                style={{ focusRing: themeColor }}
                placeholder="••••••"
                required
              />
              <button
                type="button"
                className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-500"
                onClick={() => setShowPassword(!showPassword)}
              >
                {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
              </button>
            </div>
          </div>

          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center">
              <input
                id="remember-me"
                type="checkbox"
                checked={rememberMe}
                onChange={(e) => setRememberMe(e.target.checked)}
                className="h-4 w-4 rounded border-gray-300"
                style={{ color: themeColor }}
              />
              <label htmlFor="remember-me" className="ml-2 block text-sm text-gray-700">
                Remember me
              </label>
            </div>
            <div className="text-sm">
              <a href="#" className="font-medium hover:underline" style={{ color: themeColor }}>
                Forgot password?
              </a>
            </div>
          </div>

          <Button
            type="submit"
            className="w-full py-2 px-4 rounded-lg text-white font-medium"
            style={{ backgroundColor: themeColor }}
          >
            Login
          </Button>
        </form>
      </div>
    </div>
  )
}
