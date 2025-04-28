"use client"

import { useState, useEffect } from "react"
import { useParams } from "next/navigation"
import { ProfilePageLayout } from "@/components/profile/ProfilePageLayout" // Shared layout component

export default function UserProfilePage() {
  const [userData, setUserData] = useState<any>(null)
  const [isLoadingUser, setIsLoadingUser] = useState(true)
  const params = useParams()
  const userId = params?.id

  useEffect(() => {
    const fetchUserData = async () => {
      try {
        setIsLoadingUser(true)
        const response = await fetch(`https://a2sv-hub-52ak.onrender.com/api/v0/user/${userId}`)
        const result = await response.json()
        if (response.ok) {
          setUserData(result.data)
        } else {
          console.error("Failed to fetch user data:", result.message)
        }
      } catch (error) {
        console.error("Error fetching user data:", error)
      } finally {
        setIsLoadingUser(false)
      }
    }

    if (userId) {
      fetchUserData()
    }
  }, [userId])

  return (
    <ProfilePageLayout
      userData={userData}
      isLoadingUser={isLoadingUser}
      generateMockAttendanceData={() => {
        const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        const data = []
        for (let i = 0; i < 100; i++) {
          const month = months[Math.floor(Math.random() * 12)]
          const day = Math.floor(Math.random() * 28) + 1
          const hour = Math.floor(Math.random() * 12) + 1
          const minute = Math.floor(Math.random() * 60)
          const ampm = Math.random() > 0.5 ? "AM" : "PM"
          const status = Math.random() > 0.98 ? "absent" : Math.random() > 0.95 ? "excused" : "present"
          data.push({
            date: `${day} ${month}`,
            time: `${hour}:${minute.toString().padStart(2, "0")} ${ampm}`,
            status,
          })
        }
        return data
      }}
    />
  )
}
