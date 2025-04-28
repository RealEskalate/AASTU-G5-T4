"use client"

import { useState } from "react"
import { Button } from "@/components/ui/button"
import { ForumPost } from "@/components/forum/forum-post"

// Mock data for forum posts
const forumPostsData = [
  {
    id: "1",
    author: {
      name: "Biruk Tesfaye Hanifato",
      image: "/images/profile-pic.png",
    },
    date: "22 Apr 2025 1:20 PM",
    title: "Test",
    content: "Test",
    tags: ["Fun", "Question"],
    votes: 0,
    commentCount: 1,
    comments: [
      {
        id: "c1",
        author: {
          name: "Natnael Worku Kelkile",
          image: "/images/profile-pic.png",
        },
        date: "22 Apr 2025 2:30 PM",
        content: "This is a test comment.",
        votes: 0,
      },
    ],
  },
  {
    id: "2",
    author: {
      name: "Dolphin Mulugeta Gonfa",
      image: "/images/profile-pic.png",
    },
    date: "25 Feb 2025 11:03 AM",
    title: "Codeforces - 155A ~ [Rating - 800 (Easy)]",
    subtitle: "Intuition",
    content: `You are given the contest rating of a certain user. You need to count how many times it's maximum rating and minimum rating changed throughout the given contest rating data.

## Approach
TL;DR -> We can achieve this by using two variables to register the max and the min then a counter to count how many times they changed

## Details
1, Initialization:
Create two variables, min_performance and max_performance, to store the current minimum and maximum ratings encountered so far. Initialize both of these to the first rating in the performance_list. This is crucial because the first rating is our initial baseline for both minimum and maximum.

Create a variable solution (or change_count) and initialize it to 0. This variable will track the number of times either the minimum or maximum rating changes.

2, Iteration and Comparison:
Iterate through the performance_list starting from the second element (index 1), as we've already handled the first element during initialization. For each performance rating in the list:

Check for New Maximum: If the current performance is greater than max_performance, we have a new maximum. Update max_performance to the new performance value.Increment solution (or change_count) by 1, because the maximum rating has changed.

Check for New Minimum: If the current performance is less than min_performance, we have a new minimum. Update min_performance to the new performance value.Increment solution (or change_count) by 1, because the minimum rating has changed.

3, Return Result:
After processing all performance ratings, return the solution (or change_count) value, which represents the total number of times the maximum or minimum rating changed.`,
    tags: ["Learning", "Code", "Resources", "Discussion"],
    votes: 5,
    commentCount: 3,
    comments: [
      {
        id: "c2",
        author: {
          name: "Natnael Worku Kelkile",
          image: "/images/profile-pic.png",
        },
        date: "25 Feb 2025 12:30 PM",
        content: "Great explanation! This helped me understand the problem better.",
        votes: 2,
      },
      {
        id: "c3",
        author: {
          name: "Eyasu Getaneh",
          image: "/images/profile-pic.png",
        },
        date: "25 Feb 2025 1:45 PM",
        content: "Could you explain the time complexity of this approach?",
        votes: 1,
      },
      {
        id: "c4",
        author: {
          name: "Dolphin Mulugeta Gonfa",
          image: "/images/profile-pic.png",
        },
        date: "25 Feb 2025 2:15 PM",
        content:
          "The time complexity is O(n) where n is the length of the performance list, as we're iterating through the list once.",
        votes: 3,
      },
    ],
  },
  {
    id: "3",
    author: {
      name: "Natnael Worku Kelkile",
      image: "/images/profile-pic.png",
    },
    date: "18 Feb 2025 9:45 AM",
    title: "How to approach Dynamic Programming problems?",
    content:
      "I've been struggling with DP problems lately. Any tips or resources on how to approach them systematically?\n\nI find it particularly difficult to identify the subproblems and come up with the recurrence relation. Are there any patterns or frameworks that can help with this?\n\nAlso, any recommended resources (books, websites, videos) would be greatly appreciated!",
    tags: ["Question", "Learning"],
    votes: 12,
    commentCount: 2,
    comments: [
      {
        id: "c5",
        author: {
          name: "Mahlet Seifu",
          image: "/images/profile-pic.png",
        },
        date: "18 Feb 2025 10:30 AM",
        content:
          "I recommend starting with the Fibonacci sequence and understanding how memoization works. Then move on to problems like the Knapsack problem and Longest Common Subsequence.",
        votes: 5,
      },
      {
        id: "c6",
        author: {
          name: "Eyasu Getaneh",
          image: "/images/profile-pic.png",
        },
        date: "18 Feb 2025 11:15 AM",
        content:
          "Check out 'Dynamic Programming for Coding Interviews' by Meenakshi and Kamal Rawat. It's a great resource for beginners.",
        votes: 3,
      },
    ],
  },
  {
    id: "4",
    author: {
      name: "Eyasu Getaneh",
      image: "/images/profile-pic.png",
    },
    date: "10 Feb 2025 3:22 PM",
    title: "Weekly Contest Discussion - Leetcode Contest #387",
    content:
      "Let's discuss the problems from this week's Leetcode contest. I found problem 3 particularly challenging.\n\nProblem 1 was a straightforward array manipulation problem.\n\nProblem 2 required some careful handling of edge cases.\n\nProblem 3 was a graph problem that required a specific insight to solve efficiently.\n\nProblem 4 was a hard DP problem that I couldn't solve during the contest. Has anyone figured it out?",
    tags: ["Discussion", "Contest"],
    votes: 8,
    commentCount: 1,
    comments: [
      {
        id: "c7",
        author: {
          name: "Natnael Worku Kelkile",
          image: "/images/profile-pic.png",
        },
        date: "10 Feb 2025 4:30 PM",
        content:
          "For problem 4, I used a bottom-up DP approach with state compression. The key insight was to realize that we only need to keep track of the last two states.",
        votes: 4,
      },
    ],
  },
  {
    id: "5",
    author: {
      name: "Mahlet Seifu",
      image: "/images/profile-pic.png",
    },
    date: "5 Feb 2025 11:17 AM",
    title: "Resource: Great YouTube channels for competitive programming",
    content:
      "I've compiled a list of YouTube channels that have helped me improve my competitive programming skills:\n\n1. **Errichto** - Great for contest strategies and problem-solving techniques\n\n2. **William Lin** - Amazing explanations and live contest solving\n\n3. **Algorithms Live!** - Deep dives into advanced algorithms\n\n4. **Back To Back SWE** - Excellent for interview preparation\n\n5. **Abdul Bari** - Comprehensive algorithm tutorials\n\nWhat other channels would you recommend?",
    tags: ["Resources", "Learning"],
    votes: 24,
    commentCount: 3,
    comments: [
      {
        id: "c8",
        author: {
          name: "Biruk Tesfaye Hanifato",
          image: "/images/profile-pic.png",
        },
        date: "5 Feb 2025 12:30 PM",
        content: "I would add 'Tushar Roy - Coding Made Simple' to this list. His explanations are very clear.",
        votes: 6,
      },
      {
        id: "c9",
        author: {
          name: "Dolphin Mulugeta Gonfa",
          image: "/images/profile-pic.png",
        },
        date: "5 Feb 2025 1:45 PM",
        content: "Don't forget 'Tech Dose' - they have great playlists organized by topics.",
        votes: 4,
      },
      {
        id: "c10",
        author: {
          name: "Eyasu Getaneh",
          image: "/images/profile-pic.png",
        },
        date: "5 Feb 2025 2:15 PM",
        content: "I also recommend 'Gaurav Sen' for system design and competitive programming concepts.",
        votes: 5,
      },
    ],
  },
]

export default function ForumPage() {
  const [expandedPostId, setExpandedPostId] = useState<string | null>(null)
  const [filterValue, setFilterValue] = useState("all")

  const togglePost = (postId: string) => {
    setExpandedPostId(expandedPostId === postId ? null : postId)
  }

  return (
    <div className="p-4 md:p-6 max-w-5xl mx-auto">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
        <div>
          <h1 className="text-2xl font-bold dark:text-white">Forum</h1>
          <p className="text-sm text-slate-500 dark:text-slate-400">Discussion forum</p>
        </div>
        <Button className="bg-green-500 hover:bg-green-600 text-white">
          <span className="mr-1">+</span> New Post
        </Button>
      </div>

      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6 gap-4">
        <div className="relative w-full sm:w-64">
          <select
            className="w-full p-2 border rounded-md bg-white dark:bg-slate-800 dark:border-slate-700 dark:text-white"
            value={filterValue}
            onChange={(e) => setFilterValue(e.target.value)}
          >
            <option value="all">Filter post...</option>
            <option value="questions">Questions</option>
            <option value="resources">Resources</option>
            <option value="discussions">Discussions</option>
          </select>
        </div>
        <div className="relative w-full sm:w-auto">
          <select
            className="w-full p-2 border rounded-md bg-white dark:bg-slate-800 dark:border-slate-700 dark:text-white"
            defaultValue="latest"
          >
            <option value="latest">Latest</option>
            <option value="oldest">Oldest</option>
            <option value="most_votes">Most Votes</option>
            <option value="most_comments">Most Comments</option>
          </select>
        </div>
      </div>

      <div className="space-y-6">
        {forumPostsData.map((post) => (
          <ForumPost
            key={post.id}
            post={post}
            isExpanded={expandedPostId === post.id}
            onToggle={() => togglePost(post.id)}
          />
        ))}
      </div>
    </div>
  )
}
