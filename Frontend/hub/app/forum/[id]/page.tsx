"use client"

import { useRouter } from "next/navigation"
import { Button } from "@/components/ui/button"

export default function ForumPostPage({ params }: { params: { id: string } }) {
  const router = useRouter()

  // Redirect to the main forum page since we're now using expandable posts
  // instead of separate pages
  router.push("/forum")

  return (
    <div className="p-4 flex justify-center items-center">
      <div className="text-center">
        <h1 className="text-xl font-bold mb-4">Redirecting...</h1>
        <Button onClick={() => router.push("/forum")}>Go to Forum</Button>
      </div>
    </div>
  )
}
