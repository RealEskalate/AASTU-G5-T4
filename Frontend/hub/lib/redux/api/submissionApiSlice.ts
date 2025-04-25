import { baseApiSlice } from "./baseApiSlice"
import type { Submission, SubmissionsResponse, CreateSubmissionRequest, BaseResponse } from "./types"

export const submissionApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getSubmissions: builder.query<Submission[], void>({
      query: () => "/submission",
      transformResponse: (response: SubmissionsResponse) => response.submissions || [],
      providesTags: ["Submission"],
    }),

    getSubmissionById: builder.query<Submission, number>({
      query: (id) => `/submission/${id}`,
      transformResponse: (response: BaseResponse<Submission>) => response.data as Submission,
      providesTags: (result, error, id) => [{ type: "Submission", id }],
    }),

    getSubmissionsByProblem: builder.query<Submission[], number>({
      query: (problemId) => `/submission/problem?problemID=${problemId}`,
      transformResponse: (response: SubmissionsResponse) => response.submissions || [],
      providesTags: ["Submission"],
    }),

    createSubmission: builder.mutation<Submission, CreateSubmissionRequest>({
      query: (data) => ({
        url: "/submission",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Submission>) => response.data as Submission,
      invalidatesTags: ["Submission"],
    }),

    updateSubmission: builder.mutation<Submission, { id: number; data: Partial<CreateSubmissionRequest> }>({
      query: ({ id, data }) => ({
        url: `/submission/${id}`,
        method: "PUT",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Submission>) => response.data as Submission,
      invalidatesTags: (result, error, { id }) => [{ type: "Submission", id }],
    }),
  }),
})

export const {
  useGetSubmissionsQuery,
  useGetSubmissionByIdQuery,
  useGetSubmissionsByProblemQuery,
  useCreateSubmissionMutation,
  useUpdateSubmissionMutation,
} = submissionApiSlice
