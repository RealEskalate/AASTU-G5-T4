"use client"

import type React from "react"

import { useState } from "react"
import Image from "next/image"
import { ArrowUp, ArrowDown, MessageSquare } from "lucide-react"
import { Button } from "@/components/ui/button"
import { cn } from "@/lib/utils"

interface Author {
  name: string
  image: string
}

interface Comment {
  id: string
  author: Author
  date: string
  content: string
  votes: number
}

interface Post {
  id: string
  author: Author
  date: string
  title: string
  subtitle?: string
  content: string
  tags: string[]
  votes: number
  commentCount: number
  comments?: Comment[]
}

interface ForumPostProps {
  post: Post
  isExpanded: boolean
  onToggle: () => void
}

export function ForumPost({ post, isExpanded, onToggle }: ForumPostProps) {
  const [votes, setVotes] = useState(post.votes)
  const [commentVotes, setCommentVotes] = useState<Record<string, number>>(
    Object.fromEntries((post.comments || []).map((comment) => [comment.id, comment.votes])),
  )

  const handleUpvote = (e: React.MouseEvent) => {
    e.stopPropagation()
    setVotes(votes + 1)
  }

  const handleDownvote = (e: React.MouseEvent) => {
    e.stopPropagation()
    setVotes(votes - 1)
  }

  const handleCommentUpvote = (e: React.MouseEvent, commentId: string) => {
    e.stopPropagation()
    setCommentVotes((prev) => ({
      ...prev,
      [commentId]: (prev[commentId] || 0) + 1,
    }))
  }

  const handleCommentDownvote = (e: React.MouseEvent, commentId: string) => {
    e.stopPropagation()
    setCommentVotes((prev) => ({
      ...prev,
      [commentId]: (prev[commentId] || 0) - 1,
    }))
  }

  const getTagColor = (tag: string) => {
    switch (tag.toLowerCase()) {
      case "fun":
        return "bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-300"
      case "question":
        return "bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-300"
      case "learning":
        return "bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300"
      case "code":
        return "bg-purple-100 text-purple-800 dark:bg-purple-900/30 dark:text-purple-300"
      case "resources":
        return "bg-orange-100 text-orange-800 dark:bg-orange-900/30 dark:text-orange-300"
      case "discussion":
        return "bg-indigo-100 text-indigo-800 dark:bg-indigo-900/30 dark:text-indigo-300"
      default:
        return "bg-slate-100 text-slate-800 dark:bg-slate-700 dark:text-slate-300"
    }
  }

  return (
    <div
      className={cn(
        "bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden transition-all duration-300",
        isExpanded ? "max-h-[5000px]" : "max-h-[300px]",
      )}
    >
      <div className="p-4 cursor-pointer" onClick={onToggle}>
        <div className="flex items-start gap-4">
          <div className="hidden sm:block">
            <div className="h-10 w-10 rounded-full overflow-hidden">
              <Image
                src={post.author.image || "/placeholder.svg"}
                alt={post.author.name}
                width={40}
                height={40}
                className="object-cover"
              />
            </div>
          </div>
          <div className="flex-1">
            <div className="flex items-center gap-2 mb-1">
              <div className="sm:hidden h-6 w-6 rounded-full overflow-hidden mr-1">
                <Image
                  src={post.author.image || "/placeholder.svg"}
                  alt={post.author.name}
                  width={24}
                  height={24}
                  className="object-cover"
                />
              </div>
              <span className="font-medium dark:text-white">{post.author.name}</span>
              <span className="text-xs text-slate-500 dark:text-slate-400">{post.date}</span>
            </div>
            <h3 className="text-lg font-medium dark:text-white mb-1">{post.title}</h3>
            {post.subtitle && <h4 className="text-xl font-bold dark:text-white mb-2">{post.subtitle}</h4>}

            {/* Content section - conditionally rendered based on expanded state */}
            {isExpanded ? (
              <div className="prose dark:prose-invert max-w-none mb-4">
                {post.content.split("\n\n").map((paragraph, index) => {
                  if (paragraph.startsWith("##")) {
                    return (
                      <h3 key={index} className="text-lg font-bold mt-6 mb-2 dark:text-white">
                        {paragraph.replace("##", "").trim()}
                      </h3>
                    )
                  }
                  return (
                    <p key={index} className="mb-4 text-slate-700 dark:text-slate-300">
                      {paragraph}
                    </p>
                  )
                })}
              </div>
            ) : (
              <div className="line-clamp-2 text-sm text-slate-700 dark:text-slate-300 mb-4">
                {post.content.split("\n\n")[0]}
              </div>
            )}

            <div className="flex flex-wrap gap-2 mt-3">
              {post.tags.map((tag) => (
                <span
                  key={tag}
                  className={cn(
                    "inline-flex items-center px-2 py-1 rounded-full text-xs font-medium",
                    getTagColor(tag),
                  )}
                >
                  {tag}
                </span>
              ))}
            </div>

            <div className="flex items-center gap-4 mt-4">
              <div className="flex items-center">
                <Button variant="ghost" size="icon" className="h-8 w-8" onClick={handleUpvote}>
                  <ArrowUp className="h-4 w-4" />
                </Button>
                <span className="text-sm dark:text-white">{votes}</span>
                <Button variant="ghost" size="icon" className="h-8 w-8" onClick={handleDownvote}>
                  <ArrowDown className="h-4 w-4" />
                </Button>
              </div>
              <div className="flex items-center gap-1 text-sm text-slate-500 dark:text-slate-400">
                <MessageSquare className="h-4 w-4" />
                <span>
                  {post.commentCount} Comment{post.commentCount !== 1 ? "s" : ""}
                </span>
              </div>
              {isExpanded && (
                <div className="ml-auto">
                  <Button variant="outline" size="sm" className="text-green-500 border-green-500">
                    Write A Comment
                  </Button>
                </div>
              )}
            </div>

            {/* Comments section - only shown when expanded */}
            {isExpanded && post.comments && post.comments.length > 0 && (
              <div className="mt-6 border-t dark:border-slate-700 pt-4">
                <h4 className="text-md font-medium dark:text-white mb-4">Comments</h4>
                <div className="space-y-4">
                  {post.comments.map((comment) => (
                    <div key={comment.id} className="bg-slate-50 dark:bg-slate-700/50 rounded-lg p-3">
                      <div className="flex items-start gap-3">
                        <div className="h-8 w-8 rounded-full overflow-hidden">
                          <Image
                            src={comment.author.image || "/placeholder.svg"}
                            alt={comment.author.name}
                            width={32}
                            height={32}
                            className="object-cover"
                          />
                        </div>
                        <div className="flex-1">
                          <div className="flex items-center gap-2 mb-1">
                            <span className="font-medium dark:text-white">{comment.author.name}</span>
                            <span className="text-xs text-slate-500 dark:text-slate-400">{comment.date}</span>
                          </div>
                          <p className="text-sm text-slate-700 dark:text-slate-300 mb-2">{comment.content}</p>
                          <div className="flex items-center">
                            <Button
                              variant="ghost"
                              size="icon"
                              className="h-6 w-6"
                              onClick={(e) => handleCommentUpvote(e, comment.id)}
                            >
                              <ArrowUp className="h-3 w-3" />
                            </Button>
                            <span className="text-xs dark:text-white">{commentVotes[comment.id]}</span>
                            <Button
                              variant="ghost"
                              size="icon"
                              className="h-6 w-6"
                              onClick={(e) => handleCommentDownvote(e, comment.id)}
                            >
                              <ArrowDown className="h-3 w-3" />
                            </Button>
                          </div>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>

                {/* Add comment form */}
                <div className="mt-4">
                  <textarea
                    className="w-full border rounded-md p-3 mb-4 dark:bg-slate-700 dark:border-slate-600 dark:text-white"
                    rows={3}
                    placeholder="Write your comment here..."
                    onClick={(e) => e.stopPropagation()}
                  ></textarea>
                  <div className="flex justify-end">
                    <Button className="bg-green-500 hover:bg-green-600 text-white" onClick={(e) => e.stopPropagation()}>
                      Submit Comment
                    </Button>
                  </div>
                </div>
              </div>
            )}
          </div>
        </div>
      </div>
    </div>
  )
}
