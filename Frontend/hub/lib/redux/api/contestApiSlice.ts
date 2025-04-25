import { baseApiSlice } from "./baseApiSlice"
import type { Contest, ContestsResponse, BaseResponse } from "./types"

export const contestApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getContests: builder.query<Contest[], void>({
      query: () => "/contest",
      transformResponse: (response: ContestsResponse) => response.contests || [],
      providesTags: ["Contest"],
    }),

    getContestById: builder.query<Contest, number>({
      query: (id) => `/contest/${id}`,
      transformResponse: (response: BaseResponse<Contest>) => response.data as Contest,
      providesTags: (result, error, id) => [{ type: "Contest", id }],
    }),
  }),
})

export const { useGetContestsQuery, useGetContestByIdQuery } = contestApiSlice
