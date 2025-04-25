import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react"

// Base API slice that will be extended by other API slices
export const baseApiSlice = createApi({
  reducerPath: "api",
  baseQuery: fetchBaseQuery({
    baseUrl: process.env.NEXT_PUBLIC_API_BASE_URL || "https://a2sv-hub-52ak.onrender.com/api/v0",
  }),
  tagTypes: ["Problem", "Track", "SuperGroup", "Group", "Country", "User", "Submission", "Contest", "Role", "Invite"],
  endpoints: () => ({}),
})
