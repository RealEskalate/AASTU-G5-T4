// This file is a barrel export for all API slices
import { baseApiSlice } from "./baseApiSlice"
import { problemApiSlice } from "./problemApiSlice"

// Export all API slices
export { baseApiSlice, problemApiSlice }

// Export hooks from problem API slice
export {
  useGetProblemsQuery,
  useGetProblemByIdQuery,
} from "./problemApiSlice"

import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react"

export interface Problem {
  ID: number
  ContestID: number | null
  TrackID: number | null
  Name: string
  Difficulty: string
  Tag: string
  Platform: string
  Link: string
  CreatedAt: string
  UpdatedAt: string
  Contest: any | null
  Track: any | null
}

export interface ProblemsResponse {
  problems: Problem[]
}

export interface SuperGroup {
  ID: number
  Name: string
  CreatedAt: string
  UpdatedAt: string
}

export interface Track {
  ID: number
  Name: string
  CreatedAt: string
  UpdatedAt: string
  Active: boolean
  SuperGroupID: number
  SuperGroup: SuperGroup
}

export interface TracksResponse {
  tracks: Track[]
}

export const apiSlice = createApi({
  reducerPath: "api",
  baseQuery: fetchBaseQuery({ baseUrl: "https://a2sv-hub-52ak.onrender.com/api/v0" }),
  tagTypes: ["Problem", "Track"],
  endpoints: (builder) => ({
    getProblems: builder.query<Problem[], void>({
      query: () => "/problem",
      transformResponse: (response: ProblemsResponse) => response.problems,
      providesTags: ["Problem"],
    }),
    getProblemById: builder.query<Problem, number>({
      query: (id) => `/problem/${id}`,
      providesTags: (result, error, id) => [{ type: "Problem", id }],
    }),
    getTracks: builder.query<Track[], void>({
      query: () => "/track",
      transformResponse: (response: TracksResponse) => response.tracks,
      providesTags: ["Track"],
    }),
    getTrackById: builder.query<Track, number>({
      query: (id) => `/track/${id}`,
      providesTags: (result, error, id) => [{ type: "Track", id }],
    }),
  }),
})

export const { useGetTracksQuery, useGetTrackByIdQuery } = apiSlice
