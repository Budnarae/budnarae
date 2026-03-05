import { QuartzTransformerPlugin } from "../types"

export interface R2VideoOptions {
  /**
   * 예: "https://cdn.budnarae.com" 또는 "https://<ACCOUNT_ID>.r2.cloudflarestorage.com"
   * 끝에 / 붙여도 됨.
   */
  baseUrl: string
  /** 기본: "videos" */
  prefix?: string
  /** 기본: true */
  controls?: boolean
  /** 기본: "metadata" */
  preload?: "none" | "metadata" | "auto"
}

export const R2Video: QuartzTransformerPlugin<R2VideoOptions> = (opts) => {
  const base = (opts?.baseUrl ?? "").replace(/\/+$/, "")
  const prefix = (opts?.prefix ?? "videos").replace(/^\/+|\/+$/g, "")
  const controls = opts?.controls ?? true
  const preload = opts?.preload ?? "metadata"

  if (!base) {
    throw new Error("[R2Video] baseUrl is required")
  }

  // ![[something.mp4]] 형태를 video 태그로 치환
  const re = /!\[\[([^\]]+?\.mp4)\]\]/gi

  return {
    name: "R2Video",
    textTransform(_ctx, src) {
      return src.replace(re, (_match, rawName: string) => {
        // Obsidian에서 ![[폴더/파일.mp4]] 같이 쓸 수도 있어 방어
        const fileName = rawName.split("/").pop() ?? rawName

        // 공백/한글/특수문자 URL 인코딩
        const encoded = encodeURIComponent(fileName)

        const url = `${base}/${prefix}/${encoded}`
        const controlsAttr = controls ? " controls" : ""

        return `<video${controlsAttr} preload="${preload}" style="width: 100%;" playsinline>
  <source src="${url}" type="video/mp4" />
</video>`
      })
    },
  }
}