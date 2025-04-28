import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react"

// Define the base API slice with proper configuration
export const baseApiSlice = createApi({
  reducerPath: "api",
  baseQuery: fetchBaseQuery({
    baseUrl: "https://a2sv-hub-52ak.onrender.com/api/v0",
    prepareHeaders: (headers) => {
      // Add necessary headers to avoid CORS issues
      headers.set("Accept", "application/json")
      headers.set("Content-Type", "application/json")
      return headers
    },
    credentials: "omit", // Don't send cookies with the request
  }),
  tagTypes: [
    "Problem",
    "Track",
    "User",
    "Group",
    "Country",
    "Submission",
    "Contest",
    "SuperGroup",
    "Role",
    "Invite",
    "Session",
  ],
  endpoints: () => ({}),
})
