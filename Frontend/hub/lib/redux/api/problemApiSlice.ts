import { baseApiSlice } from "./baseApiSlice"

// Define the Problem interface based on the API response
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

export const problemApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getProblems: builder.query<Problem[], void>({
      query: () => "/problem",
      transformResponse: (response: any) => {
        console.log("Raw API response:", response)

        // Check if the response has the expected structure
        if (response && Array.isArray(response)) {
          return response
        }

        // If response has a problems property
        if (response && Array.isArray(response.problems)) {
          return response.problems
        }

        // If response is wrapped in a data property
        if (response && response.data && Array.isArray(response.data)) {
          return response.data
        }

        // If none of the above, return empty array
        console.warn("Unexpected response format:", response)
        return []
      },
      providesTags: ["Problem"],
    }),

    getProblemById: builder.query<Problem, number>({
      query: (id) => `/problem/${id}`,
      transformResponse: (response: any) => {
        console.log("Raw problem by ID response:", response)

        // Check if response has the problem directly
        if (response && response.ID) {
          return response
        }

        // Check if response has a problem property
        if (response && response.problem && response.problem.ID) {
          return response.problem
        }

        // Check if response has data property
        if (response && response.data && response.data.ID) {
          return response.data
        }

        console.warn("Unexpected problem response format:", response)
        return {} as Problem
      },
      providesTags: (result, error, id) => [{ type: "Problem", id }],
    }),
  }),
})

export const { useGetProblemsQuery, useGetProblemByIdQuery } = problemApiSlice
