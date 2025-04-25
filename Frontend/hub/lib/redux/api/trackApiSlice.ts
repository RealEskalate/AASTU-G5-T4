import { baseApiSlice } from "./baseApiSlice"
import type { Track, TracksResponse, CreateTrackRequest, BaseResponse } from "./types"

export const trackApiSlice = baseApiSlice.injectEndpoints({
  endpoints: (builder) => ({
    getTracks: builder.query<Track[], void>({
      query: () => "/track",
      transformResponse: (response: TracksResponse) => response.tracks || [],
      providesTags: ["Track"],
    }),

    getTrackById: builder.query<Track, number>({
      query: (id) => `/track/${id}`,
      transformResponse: (response: BaseResponse<Track>) => response.data as Track,
      providesTags: (result, error, id) => [{ type: "Track", id }],
    }),

    createTrack: builder.mutation<Track, CreateTrackRequest>({
      query: (data) => ({
        url: "/track",
        method: "POST",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Track>) => response.data as Track,
      invalidatesTags: ["Track"],
    }),

    updateTrack: builder.mutation<Track, { id: number; data: Partial<CreateTrackRequest> }>({
      query: ({ id, data }) => ({
        url: `/track/${id}`,
        method: "PUT",
        body: data,
      }),
      transformResponse: (response: BaseResponse<Track>) => response.data as Track,
      invalidatesTags: (result, error, { id }) => [{ type: "Track", id }],
    }),
  }),
})

export const { useGetTracksQuery, useGetTrackByIdQuery, useCreateTrackMutation, useUpdateTrackMutation } = trackApiSlice
