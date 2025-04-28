import { baseApiSlice } from "./baseApiSlice"
import type { Session, SessionsResponse, SessionResponse } from "./types"

export const sessionApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getSessions: builder.query<SessionsResponse, void>({
      query: () => "/session",
      providesTags: ["Session"],
    }),

    getSessionById: builder.query<SessionResponse, number>({
      query: (id) => `/session/${id}`,
      providesTags: (result, error, id) => [{ type: "Session", id }],
    }),

    createSession: builder.mutation<SessionResponse, Partial<Session>>({
      query: (data) => ({
        url: "/session",
        method: "POST",
        body: data,
      }),
      invalidatesTags: ["Session"],
    }),

    updateSession: builder.mutation<SessionResponse, { id: number; data: Partial<Session> }>({
      query: ({ id, data }) => ({
        url: `/session/${id}`,
        method: "PUT",
        body: data,
      }),
      invalidatesTags: (result, error, { id }) => [{ type: "Session", id }],
    }),

    deleteSession: builder.mutation<void, number>({
      query: (id) => ({
        url: `/session/${id}`,
        method: "DELETE",
      }),
      invalidatesTags: ["Session"],
    }),
  }),
})

export const {
  useGetSessionsQuery,
  useGetSessionByIdQuery,
  useCreateSessionMutation,
  useUpdateSessionMutation,
  useDeleteSessionMutation,
} = sessionApiSlice
