import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react"

export const contestApi = createApi({
  reducerPath: "contestApi",
  baseQuery: fetchBaseQuery({ baseUrl: "https://a2sv-hub-52ak.onrender.com/api/v0" }),
  endpoints: (builder) => ({
    getContests: builder.query<any, void>({
      query: () => "/contest",
    }),
    getContestById: builder.query<any, number>({
      query: (id) => `/contest/${id}`,
    }),
  }),
})

export const { useGetContestsQuery, useGetContestByIdQuery } = contestApi
