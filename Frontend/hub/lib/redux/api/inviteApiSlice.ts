import { baseApiSlice } from "./baseApiSlice"
import type { Invite, InviteRequest, BatchInviteRequest, BaseResponse, User } from "./types"

export const inviteApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    createInvite: builder.mutation<Invite, InviteRequest>({
      query: (data) => ({
        url: "/invites",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Invite>) => response.data as Invite,
      invalidatesTags: ["Invite"],
    }),

    createBatchInvites: builder.mutation<Invite[], BatchInviteRequest>({
      query: (data) => ({
        url: "/invites/batch",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Invite[]>) => response.data as Invite[],
      invalidatesTags: ["Invite"],
    }),

    acceptInvite: builder.query<User, string>({
      query: (token) => `/invites/${token}`,
      transformResponse: (response: BaseResponse<User>) => response.data as User,
      providesTags: ["User"],
    }),
  }),
})

export const { useCreateInviteMutation, useCreateBatchInvitesMutation, useAcceptInviteQuery } = inviteApiSlice
